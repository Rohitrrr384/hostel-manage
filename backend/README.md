# HostelSync Backend

Express + MongoDB API for the HostelSync Flutter app.

## Setup

```bash
cd backend
npm install
copy .env.example .env
npm run mongo:init
npm run mongo
```

Keep that MongoDB terminal open. In a second terminal:

```bash
cd backend
npm run seed
npm run dev
```

API base URL:

```text
http://localhost:5000/api
```

## Demo Logins

All seeded users use password:

```text
password
```

- `student@hostelsync.app`
- `warden@hostelsync.app`
- `security@hostelsync.app`
- `mess@hostelsync.app`
- `admin@hostelsync.app`

## Registering Students

Users do not self-register in this hostel workflow. An admin creates the account, then gives the user their email and temporary password.

For any role:

```http
POST /api/users
Authorization: Bearer <admin-token>
Content-Type: application/json
```

```json
{
  "name": "Sita Rao",
  "email": "sita.warden@hostelsync.app",
  "phone": "9876500020",
  "role": "warden",
  "hostelName": "Girls Hostel B",
  "password": "password"
}
```

Allowed roles:

```text
student, warden, security, mess, admin
```

For student registration with automatic room linking, use:

```http
POST /api/users/students
Authorization: Bearer <admin-token>
Content-Type: application/json
```

```json
{
  "name": "Aman Verma",
  "email": "aman@hostelsync.app",
  "phone": "9876500010",
  "studentId": "CS24B010",
  "roomNumber": "A-210",
  "block": "A",
  "hostelName": "Boys Hostel A",
  "password": "password"
}
```

If `password` is omitted, the API creates one as:

```text
<studentId>@123
```

The student then signs in through:

```http
POST /api/auth/login
```

## Main Modules

- Auth and role-based access
- Users
- Leave requests
- Complaints
- Mess menu, attendance, feedback
- Notices
- Visitors
- Laundry slots
- Rooms
- Marketplace
- Lost and found
- Notifications
- Admin analytics summary
