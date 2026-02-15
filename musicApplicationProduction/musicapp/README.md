# One Music 🎵

![Next.js](https://img.shields.io/badge/Next.js-16.1-black?style=for-the-badge&logo=next.js&logoColor=white)
![React](https://img.shields.io/badge/React-19-blue?style=for-the-badge&logo=react&logoColor=white)
![TypeScript](https://img.shields.io/badge/TypeScript-5.0-blue?style=for-the-badge&logo=typescript&logoColor=white)
![Tailwind CSS](https://img.shields.io/badge/Tailwind_CSS-4.0-38B2AC?style=for-the-badge&logo=tailwind-css&logoColor=white)
![Supabase](https://img.shields.io/badge/Supabase-Backend-green?style=for-the-badge&logo=supabase&logoColor=white)
![Clerk](https://img.shields.io/badge/Clerk-Auth-purple?style=for-the-badge&logo=clerk&logoColor=white)

**One Music** is a modern, responsive music streaming application built with the latest web technologies. It features a sleek user interface, seamless playback, user authentication, and robust playlist management.

## 🚀 Features

- **User Authentication**: Secure sign-up and sign-in powered by [Clerk](https://clerk.com/).
- **Music Playback**:
  - Global music player with play, pause, next/previous controls.
  - Streaming support (HLS.js integration).
  - Background playback persistence across navigation.
- **Content Discovery**:
  - **Hero Section**: Highlights featured or trending songs.
  - **Artist Spotlights**: Dedicated pages and cards for artists.
  - **Suggested Songs**: Curated list of songs for discovery.
- **Playlist Management**:
  - Create, edit, and delete personal playlists.
  - Add songs to playlists.
  - View "My Playlists" and "Favorites".
- **User Library**:
  - **History**: Tracks recently played songs.
  - **Favorites**: Quickly access liked songs.
- **Responsive Design**: Fully responsive UI tailored for desktop, tablet, and mobile devices using Tailwind CSS.
- **Modern UI/UX**:
  - Dark mode enabled by default.
  - Smooth transitions and animations.
  - Toast notifications for user actions (via `sonner`).

## 🛠️ Tech Stack

- **Framework**: [Next.js 16](https://nextjs.org/) (App Router)
- **Language**: [TypeScript](https://www.typescriptlang.org/)
- **Styling**: [Tailwind CSS 4](https://tailwindcss.com/)
- **State Management**: [Zustand](https://github.com/pmndrs/zustand)
- **Authentication**: [Clerk](https://clerk.com/)
- **Backend / Database**: [Supabase](https://supabase.com/)
- **UI Components**: [Radix UI](https://www.radix-ui.com/) & [Lucide React](https://lucide.dev/) (Icons)
- **Deployment**: Optimized for [Vercel](https://vercel.com/).

## 📂 Project Structure

```bash
src/
├── app/                  # Next.js App Router pages and layouts
│   ├── artist/           # Artist detail pages
│   ├── playlist/         # Global playlist pages
│   ├── userplaylist/     # User-specific playlist pages
│   ├── favourites/       # User favorites page
│   ├── history/          # User listening history
│   ├── layout.tsx        # Root layout with Sidebar, Navbar, and Player
│   └── page.tsx          # Home page (Hero, Suggestions, etc.)
├── components/           # React components
│   ├── custom/           # App-specific components (Player, Sidebar, Cards)
│   └── ui/               # Reusable UI primitives (Buttons, Inputs - likely shadcn/ui)
├── lib/                  # Utility functions and configurations
│   ├── supabase.ts       # Supabase client configuration
│   └── utils.ts          # General helper functions
├── Store/                # Zustand state stores
│   ├── AllSongsStore.ts
│   ├── UserStore.ts
│   ├── CurrentlyPlayingSongsStore.ts
│   └── ... (stores for playlists, artists, history)
└── types/                # TypeScript type definitions
```

## ⚡ Getting Started

### Prerequisites

- Node.js (v18 or higher recommended)
- npm or pnpm
- A generic Supabase project
- A Clerk application

### Installation

1.  **Clone the repository:**

    ```bash
    git clone https://github.com/your-username/musicapp.git
    cd musicapp
    ```

2.  **Install dependencies:**

    ```bash
    npm install
    # or
    pnpm install
    ```

3.  **Environment Setup:**

    Create a `.env.local` file in the root directory and add the following variables:

    ```env
    # Supabase
    NEXT_PUBLIC_SUPABASE_URL=your_supabase_url
    NEXT_SUPABASE_SERVICE_ROLE_KEY=your_supabase_service_role_key

    # Clerk Auth
    NEXT_PUBLIC_CLERK_PUBLISHABLE_KEY=your_clerk_publishable_key
    CLERK_SECRET_KEY=your_clerk_secret_key

    # AWS (If applicable for S3 storage)
    AWS_REGION=your_aws_region
    AWS_ACCESS_KEY_ID=your_access_key
    AWS_SECRET_ACCESS_KEY=your_secret_key
    AWS_BUCKET_NAME=your_bucket_name
    ```

4.  **Run the Development Server:**

    ```bash
    npm run dev
    # or
    pnpm dev
    ```

    Open [http://localhost:3000](http://localhost:3000) with your browser to see the result.

## 📜 Available Scripts

In the project directory, you can run:

- `npm run dev`: Runs the app in development mode.
- `npm run build`: Builds the app for production.
- `npm run start`: Runs the built app in production mode.
- `npm run lint`: Runs the linter to find code issues.

## 🧠 State Management

This project uses **Zustand** for efficient global state management. Key stores include:

- `CurrentlyPlayingSongsStore`: Manages the current song, queue, and playback status.
- `UserStore`: Context for the logged-in user.
- `AllSongsStore`, `AllArtistsStore`, `AllPlaylistStore`: Caches for data fetched from the backend to minimize redundant API calls.

## 🔒 Authentication

Authentication is handled securely via **Clerk**.

- Middleware protects private routes (e.g., `/favourites`, `/history`).
- User data is synced with the application state on login.

## 🤝 Contributing

Contributions are welcome! Please follow these steps:

1.  Fork the repository.
2.  Create a new branch (`git checkout -b feature/YourFeature`).
3.  Commit your changes (`git commit -m 'Add some feature'`).
4.  Push to the branch (`git push origin feature/YourFeature`).
5.  Open a Pull Request.

## 📄 License

This project is licensed under the MIT License.
