INSERT INTO "user" (id, first_name, last_name, phone_number, organization_id, status, "createdAt", "updatedAt", email)
VALUES (
    '5552cd61-8807-4eda-a70c-d4f3d9fa7fd9',
    'External',
    'Reporter Eugene',
    '1234567890',
    1,
    'Active',
    now(),
    now(),
    'johndoe@example.com'
);

insert into incidence (id, lat, long, "userId", incidence_type_id, "date", exists_votes, internal_report)
values ('f420ed51-27df-41a2-bccb-9f5cc25a2d0e','44.039200','-123.072050','5552cd61-8807-4eda-a70c-d4f3d9fa7fd9','e23e4567-e89b-12d3-a456-426655440000',TO_TIMESTAMP('06/07/2023 06:20:42 PM', 'MM/DD/YYYY HH:MI:SS PM')
  AT TIME ZONE 'PST'
  AT TIME ZONE 'UTC', 0, false);

insert into incidence (id, lat, long, "userId", incidence_type_id, "date", exists_votes, internal_report)
values ('f420ed51-27df-41a2-bccb-9f5cc25a2d1e','44.174450','-123.163870','5552cd61-8807-4eda-a70c-d4f3d9fa7fd9','223f4567-e89b-12d3-a456-426655440000',TO_TIMESTAMP('06/07/2023 06:16:56 PM', 'MM/DD/YYYY HH:MI:SS PM')
  AT TIME ZONE 'PST'
  AT TIME ZONE 'UTC', 0, false);

insert into incidence (id, lat, long, "userId", incidence_type_id, "date", exists_votes, internal_report)
values ('f420ed51-27df-41a2-bccb-9f5cc25a2d2e','44.048510','-123.095040','5552cd61-8807-4eda-a70c-d4f3d9fa7fd9','523e4567-e89b-12d3-a456-426655440000',TO_TIMESTAMP('06/07/2023 05:47:21 PM', 'MM/DD/YYYY HH:MI:SS PM')
  AT TIME ZONE 'PST'
  AT TIME ZONE 'UTC', 0, false);

insert into incidence (id, lat, long, "userId", incidence_type_id, "date", exists_votes, internal_report)
values ('f420ed51-27df-41a2-bccb-9f5cc25a2d3e','44.248510','-123.195040','5552cd61-8807-4eda-a70c-d4f3d9fa7fd9','b23e4567-e89b-12d3-a456-426655440000',TO_TIMESTAMP('06/07/2023 08:19:21 PM', 'MM/DD/YYYY HH:MI:SS PM')
  AT TIME ZONE 'PST'
  AT TIME ZONE 'UTC', 0, false);

insert into incidence (id, lat, long, "userId", incidence_type_id, "date", exists_votes, internal_report)
values ('f420ed51-27df-41a2-bccb-9f5cc25a2d4e','44.148510','-122.995040','5552cd61-8807-4eda-a70c-d4f3d9fa7fd9','c23e4567-e89b-12d3-a456-426655440000',TO_TIMESTAMP('06/07/2023 09:10:34 PM', 'MM/DD/YYYY HH:MI:SS PM')
  AT TIME ZONE 'PST'
  AT TIME ZONE 'UTC', 0, false);

insert into incidence (id, lat, long, "userId", incidence_type_id, "date", exists_votes, internal_report)
values ('f420ed51-27df-41a2-bccb-9f5cc25a25e','44.348510','-123.495040','5552cd61-8807-4eda-a70c-d4f3d9fa7fd9','123e4567-e89b-12d3-a456-426655440000',TO_TIMESTAMP('06/07/2023 05:42:21 PM', 'MM/DD/YYYY HH:MI:SS PM')
  AT TIME ZONE 'PST'
  AT TIME ZONE 'UTC', 0, false);

insert into incidence (id, lat, long, "userId", incidence_type_id, "date", exists_votes, internal_report)
values ('f420ed51-27df-41a2-bccb-9f5cc25a26e','45.048510','-123.485040','5552cd61-8807-4eda-a70c-d4f3d9fa7fd9','423e4567-e89b-12d3-a456-426655440000',TO_TIMESTAMP('06/07/2023 05:56:21 PM', 'MM/DD/YYYY HH:MI:SS PM')
  AT TIME ZONE 'PST'
  AT TIME ZONE 'UTC', 0, false);

insert into incidence (id, lat, long, "userId", incidence_type_id, "date", exists_votes, internal_report)
values ('f420ed51-27df-41a2-bccb-9f5cc25a28e','43.048510','-123.285040','5552cd61-8807-4eda-a70c-d4f3d9fa7fd9','223e4567-e89b-12d3-a456-426655440000',TO_TIMESTAMP('06/07/2023 06:34:21 PM', 'MM/DD/YYYY HH:MI:SS PM')
  AT TIME ZONE 'PST'
  AT TIME ZONE 'UTC', 0, false);

insert into incidence (id, lat, long, "userId", incidence_type_id, "date", exists_votes, internal_report)
values ('f420ed51-27df-41a2-bccb-9f5cc25a29e','43.248610','-123.224040','5552cd61-8807-4eda-a70c-d4f3d9fa7fd9','523e4567-e89b-12d3-a456-426655440000',TO_TIMESTAMP('06/07/2023 04:20:10 PM', 'MM/DD/YYYY HH:MI:SS PM')
  AT TIME ZONE 'PST'
  AT TIME ZONE 'UTC', 0, false);
