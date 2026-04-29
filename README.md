# Connectify

A cross-platform social networking app built with Flutter and Supabase. Users can create posts, reply to them, like content, search for other users, and receive real-time notifications.

---

## Screenshots

| Home | Add Comment | Notifications |
|------|-------------|---------------|
| ![Home](assets/screenshots/home_page.jpg) | ![Add Comment](assets/screenshots/add_comment.jpg) | ![Notifications](assets/screenshots/notifications_page.jpg) |

| Search | User Profile | Other User Profile |
|--------|--------------|--------------------|
| ![Search](assets/screenshots/search_page.jpg) | ![User Profile](assets/screenshots/user_profile_page.jpg) | ![Other User](assets/screenshots/other_user_page.jpg) |

---

## Features

- Authentication — Register, login, logout, and session persistence across app restarts
- Forgot Password — Password reset via email link through Supabase Auth
- Posts (Connectify) — Create posts with text and optional images
- Replies — Comment on any post
- Likes — Like and unlike posts
- Notifications — Get notified when someone likes or replies to your post
- User Profiles — View and edit your profile including name, bio, and avatar
- Search — Find other users by name
- Connectivity Monitoring — Real-time internet connection detection with user feedback
- Settings — Account management, privacy policy, terms of service, and help centre

---

## Tech Stack

| Layer              | Technology                           |
| ------------------ | ------------------------------------ |
| Framework          | Flutter (SDK >= 3.4.3)               |
| State Management   | GetX                                 |
| Backend and Auth   | Supabase                             |
| Database           | PostgreSQL (via Supabase)            |
| File Storage       | Supabase Storage (S3-compatible)     |
| Local Storage      | GetStorage                           |
| Image Handling     | image_picker, flutter_image_compress |
| Environment Config | flutter_dotenv                       |

---

## Project Structure

```
lib/
├── controllers/        # GetX controllers for each feature
│   ├── auth_controller.dart
│   ├── home_controller.dart
│   ├── notification_controller.dart
│   ├── post_controller.dart
│   ├── profile_controller.dart
│   ├── reply_controller.dart
│   ├── search_user.dart
│   └── setting_controller.dart
├── models/             # Data models mapped from Supabase responses
│   ├── user_model.dart
│   ├── post_model.dart
│   ├── reply_model.dart
│   ├── likes_model.dart
│   └── notification_model.dart
├── routes/             # Named route definitions and page registration
├── services/           # App-level services
│   ├── supabase_service.dart     # Supabase init and auth state listener
│   ├── storage_service.dart      # GetStorage session wrapper
│   ├── connectivity_service.dart # Internet connectivity monitor
│   ├── navigation_service.dart
│   └── permission_service.dart
├── theme/              # App-wide Material theme (dark)
├── utils/              # Env loader, helpers, constants, typedefs
├── views/              # Screens organised by feature
│   ├── auth/           # Login, Register, Forgot Password
│   ├── home/
│   ├── notification/
│   ├── profile/
│   ├── replies/
│   ├── search/
│   ├── setting/
│   └── shareTogether/  # Post creation and viewing
├── widgets/            # Reusable UI components
└── main.dart
```

---

## Supabase Setup

Connectify uses Supabase for authentication, database, and file storage.

### Authentication

Supabase Auth handles user registration, login, session management, and password reset emails. User metadata (name, avatar, bio) is stored in the `raw_user_meta_data` field on the `auth.users` table.

### Database (PostgreSQL)

The following tables are required in your Supabase project.

#### posts

```sql
create table posts (
  id            bigint generated always as identity primary key,
  user_id       uuid references auth.users(id) on delete cascade not null,
  content       text,
  image         text,
  video         text,
  like_count    int default 0,
  comment_count int default 0,
  created_at    timestamptz default now()
);
```

#### replies

```sql
create table replies (
  id         bigint generated always as identity primary key,
  user_id    uuid references auth.users(id) on delete cascade not null,
  post_id    bigint references posts(id) on delete cascade not null,
  reply      text not null,
  created_at timestamptz default now()
);
```

#### likes

```sql
create table likes (
  post_id    bigint references posts(id) on delete cascade not null,
  user_id    uuid references auth.users(id) on delete cascade not null,
  primary key (post_id, user_id)
);
```

#### notifications

```sql
create table notifications (
  id           bigint generated always as identity primary key,
  user_id      uuid references auth.users(id) on delete cascade not null,
  post_id      bigint references posts(id) on delete cascade,
  notification text not null,
  created_at   timestamptz default now()
);
```

### Row Level Security (RLS)

Enable RLS on all tables. At minimum, apply the following policies.

Allow authenticated users to read all posts:

```sql
create policy "Public read" on posts
  for select using (true);
```

Allow users to insert and delete only their own rows (apply the same pattern to replies, likes, and notifications):

```sql
create policy "Owner insert" on posts
  for insert with check (auth.uid() = user_id);

create policy "Owner delete" on posts
  for delete using (auth.uid() = user_id);
```

### Storage

Create a storage bucket matching the name in your `.env` file. This bucket is used to store post images and user avatars. Set the bucket to public if you want images to be accessible without authentication, or configure signed URLs if you need private access.

---

## Getting Started

### Prerequisites

- Flutter SDK `>= 3.4.3`
- A Supabase project with the tables above created

### Setup

1. Clone the repository

   ```bash
   git clone https://github.com/your-username/connectify.git
   cd connectify
   ```

2. Install dependencies

   ```bash
   flutter pub get
   ```

3. Create a `.env` file in the project root

   ```env
   SUPABASE_URL=your_supabase_project_url
   SUPABASE_ANON_KEY=your_supabase_anon_key
   S3_BUCKET=your_storage_bucket_name
   ```

4. Run the app

   ```bash
   flutter run
   ```

---

## Environment Variables

| Variable           | Description                          |
| ------------------ | ------------------------------------ |
| `SUPABASE_URL`     | Your Supabase project URL            |
| `SUPABASE_ANON_KEY`| Your Supabase anonymous/public key   |
| `S3_BUCKET`        | Your Supabase storage bucket name    |

The `.env` file is listed in `.gitignore` and must never be committed to version control.

---

## Dependencies

| Package                  | Purpose                                      |
| ------------------------ | -------------------------------------------- |
| `get`                    | State management, routing, and dependency injection |
| `get_storage`            | Lightweight local key-value storage for session persistence |
| `supabase_flutter`       | Supabase client for auth, database, and storage |
| `flutter_dotenv`         | Load environment variables from `.env`       |
| `form_validator`         | Form field validation helpers                |
| `image_picker`           | Pick images from camera or gallery           |
| `flutter_image_compress` | Compress images before upload                |
| `uuid`                   | Generate unique identifiers                  |
| `jiffy`                  | Human-readable date and time formatting      |
| `permission_handler`     | Request media permissions on Android and iOS |
