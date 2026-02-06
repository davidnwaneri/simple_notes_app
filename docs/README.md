# SimpleNotes Landing Page

This directory contains the landing page for the SimpleNotes app, designed to be deployed via GitHub Pages.

## Contents

- `index.html` - The main landing page with app information and account deletion instructions
- `favicon.png` - The app icon

## Features

The landing page includes:
- **App Overview**: Description of SimpleNotes features and benefits
- **Feature Highlights**: Grid of key features (security, cloud sync, cross-platform, etc.)
- **Account Deletion Section**: Clear instructions for users to delete their accounts from within the app
- **Links**: Direct links to the GitHub repository and issue tracker
- **Responsive Design**: Mobile-friendly layout that works on all screen sizes

## Deploying to GitHub Pages

### Option 1: Deploy from this Repository

1. Go to your repository on GitHub
2. Navigate to **Settings** > **Pages**
3. Under "Source", select **Deploy from a branch**
4. Select the branch (e.g., `main` or your preferred branch)
5. Select the `/docs` folder
6. Click **Save**
7. Your landing page will be available at: `https://davidnwaneri.github.io/simple_notes_app/`

### Option 2: Deploy from a Separate Repository

If you prefer to have a dedicated repository for the landing page:

1. Create a new repository (e.g., `simple_notes_landing` or `simple_notes_app.github.io`)
2. Copy the contents of this `docs/` folder to the root of the new repository
3. Go to the new repository's **Settings** > **Pages**
4. Select **Deploy from a branch** and choose `main` branch with `/ (root)` folder
5. Your landing page will be available at: `https://davidnwaneri.github.io/<repository-name>/`

## Local Testing

To test the landing page locally:

1. Open `index.html` in your web browser, or
2. Use a simple HTTP server:
   ```bash
   # Python 3
   python3 -m http.server 8000
   
   # Python 2
   python -m SimpleHTTPServer 8000
   
   # Node.js (with http-server installed)
   npx http-server
   ```
3. Visit `http://localhost:8000` in your browser

## Customization

The landing page is a single, self-contained HTML file with inline CSS. You can easily customize:
- Colors and gradients in the `<style>` section
- Content in the various sections
- Feature cards
- Account deletion instructions

## Account Deletion Flow

The page directs users to delete their accounts from within the app itself, which is the recommended approach for:
- **Security**: Ensures proper authentication before deletion
- **Data integrity**: Allows the app to properly clean up user data
- **User experience**: Provides confirmation dialogs and prevents accidental deletions

## License

This landing page is part of the SimpleNotes project and is licensed under GNU GPLv3.
