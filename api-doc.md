# Moodle API Contract Notes

These notes document the expected request shapes used by the scaffold.

## Shared Query Parameters

Every REST request to `/webservice/rest/server.php` includes:

- `wstoken`
- `wsfunction`
- `moodlewsrestformat=json`

## 1. Get User Courses

Function:

`core_enrol_get_users_courses`

Request:

`GET /webservice/rest/server.php?wstoken=...&wsfunction=core_enrol_get_users_courses&moodlewsrestformat=json&userid=1003`

Expected fields used by the app:

- `id`
- `fullname` or `displayname`
- `progress` if available
- `courseimage` if available
- `overviewfiles` if available

## 2. Get Course Contents

Function:

`core_course_get_contents`

Request:

`GET /webservice/rest/server.php?wstoken=...&wsfunction=core_course_get_contents&moodlewsrestformat=json&courseid=<courseId>`

Expected fields used by the app:

- `id`
- `name`
- `summary`

Only section titles are required for the assignment, so the UI ignores module details.

## 3. Get Grades

Function:

`gradereport_user_get_grade_items`

Request:

`GET /webservice/rest/server.php?wstoken=...&wsfunction=gradereport_user_get_grade_items&moodlewsrestformat=json&courseid=<courseId>&userid=1003`

Expected fields used by the app:

- `usergrades`
- `gradeitems`
- `itemname`
- `gradeformatted`
- `percentageformatted`

## Login Token

Endpoint:

`/login/token.php`

Request shape:

`GET /login/token.php?username=student1&password=Demo@12345&service=moodle_mobile_app`

Response is expected to contain:

- `token`

## Important Implementation Assumptions

- Some Moodle installations expose slightly different optional fields
- `courseimage` is not guaranteed, so the scaffold also checks `overviewfiles`
- Grades may include summary rows; the UI can later filter those if needed
- HTML formatting may appear in names or summaries, so both apps sanitize display text

