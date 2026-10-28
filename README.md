# MoneyMate — Personal Money Manager

A Flask + MySQL finance tracker for recording income, expenses, transfers, accounts, notes, monthly history, charts, and Excel exports.

## Important authentication note

This runnable starter uses **phone number + password**, not SMS OTP. Real OTP login requires an SMS provider account and credentials. Do not present a development-only OTP as secure production authentication. Passwords are hashed. CSRF protection is enabled for forms.

## Requirements

- Python 3.10+
- MySQL 8+ (or compatible MySQL server)
- A web browser

## Setup (Windows PowerShell)

1. Extract the project ZIP.
2. Open PowerShell in the `MoneyMate` folder.
3. Create and activate a virtual environment:

```powershell
py -m venv .venv
.\.venv\Scripts\Activate.ps1
```

4. Install dependencies:

```powershell
pip install -r requirements.txt
```

5. Create the database and tables. If the MySQL command-line client is available:

```powershell
mysql -u root -p < database/schema.sql
```

Alternatively, open `database/schema.sql` in MySQL Workbench and execute it.

6. Copy `.env.example` to `.env`, then set your MySQL username and password. Use a long random `SECRET_KEY`. Do not commit `.env` to Git.

7. Start the server:

```powershell
python app.py
```

8. Open http://127.0.0.1:5000 and create an account.

## Setup (macOS/Linux)

```bash
python3 -m venv .venv
source .venv/bin/activate
pip install -r requirements.txt
mysql -u root -p < database/schema.sql
cp .env.example .env
# Edit .env with your own local database credentials.
python app.py
```

## Features included

- Registration and login using a phone number and hashed password
- Daily dashboard and recent activity
- Income and expense creation, editing, and deletion
- Transfers between accounts with source-balance validation
- Accounts and opening balances
- Month-based transaction history, filtering, and search
- Weekly/monthly/yearly chart views (based on the current period)
- Personal notes
- Excel `.xlsx` export for a selected month
- CSRF protection, parameterized SQL, and per-user record checks

## Current limitations to know about

- SMS OTP is not wired up; configure an SMS provider before using OTP in production.
- Transfer editing/deletion is intentionally disabled until a full balance-safe reversal workflow is added.
- This starter does not yet support editing notes or archiving accounts in the UI.
- The statistics page provides weekly/monthly/yearly views over the current period; arbitrary historical periods and category filters can be added next.
- Account balances are calculated from opening balances and saved transactions.
- This is a starter application. Review, test, and harden it before production deployment.

## Security reminders

- Set `FLASK_DEBUG=0` in production.
- Use HTTPS and secure cookie settings behind a properly configured production server.
- Use a strong `SECRET_KEY`.
- Restrict database access and create a dedicated least-privilege database user.
- Add rate limiting and SMS OTP verification before exposing login publicly.
- Back up your database regularly.
