import {
  Application,
  Router,
  Middleware,
} from "https://deno.land/x/oak@v11.1.0/mod.ts";
import { schema } from './schema/schema.ts'
import { GraphQLHTTP } from "https://deno.land/x/gql@1.1.2/mod.ts";
import { gql } from "https://deno.land/x/graphql_tag@0.0.1/mod.ts";

const resolve = GraphQLHTTP({
  schema,
  graphiql: true,
  context: (request) => ({ request }),
});

const handleGraphQL: Middleware = async (ctx) => {
  // cast Oak request into a normal Request
  const req = new Request(ctx.request.url.toString(), {
    body: ctx.request.originalRequest.getBody().body,
    headers: ctx.request.headers,
    method: ctx.request.method,
  });

  const res = await resolve(req);

  for (const [k, v] of res.headers.entries()) ctx.response.headers.append(k, v);

  ctx.response.status = res.status;
  ctx.response.body = res.body;
};

// Allow CORS:
// const cors: Middleware = (ctx) => {
// ctx.response.headers.append('access-control-allow-origin', '*')
// ctx.response.headers.append('access-control-allow-headers', 'Origin, Host, Content-Type, Accept')
// }

const graphqlRouter = new Router().all("/graphql", handleGraphQL);

const app = new Application().use(
  // cors,
  graphqlRouter.routes(),
  graphqlRouter.allowedMethods()
);

app.addEventListener("listen", ({ secure, hostname, port }) => {
  if (hostname === "0.0.0.0") hostname = "localhost";

  const protocol = secure ? "https" : "http";
  const url = `${protocol}://${hostname ?? "localhost"}:${port}`;

  console.log("☁  Started on " + url);
});

await app.listen({ port: 3000 });
