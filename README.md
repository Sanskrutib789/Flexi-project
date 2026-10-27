# FLEXI Jewelry — Full-Stack Haute Joaillerie E-Commerce Platform

A complete, production-grade luxury jewelry e-commerce web application crafted with a refined high-end aesthetic (**champagne gold, ivory, jet black, and warm neutrals**). Features an **Express.js & MongoDB** REST API backend coupled with a responsive **React 18 & Vite** frontend.

---

## 💎 Table of Contents

- [Architectural Overview](#architectural-overview)
- [Design Aesthetic & Color Palette](#design-aesthetic--color-palette)
- [Key Features](#key-features)
- [Security & Business Logic](#security--business-logic)
- [Technology Stack](#technology-stack)
- [Project Directory Structure](#project-directory-structure)
- [Database Setup (Local & MongoDB Atlas)](#database-setup-local--mongodb-atlas)
- [Database Seeding & Demo Accounts](#database-seeding--demo-accounts)
- [Promoting an Administrator](#promoting-an-administrator)
- [Running the Application](#running-the-application)
- [REST API Endpoint Documentation](#rest-api-endpoint-documentation)
- [Git & GitHub Deployment Status](#git--github-deployment-status)

---

## 🏛 Architectural Overview

```
                      ┌────────────────────────────────────────┐
                      │          React 18 + Vite               │
                      │     (Tailwind, React Router, Axios)    │
                      └───────────────────┬────────────────────┘
                                          │
                                 HTTP / JSON (JWT)
                                          │
                      ┌───────────────────▼────────────────────┐
                      │        Node.js + Express.js            │
                      │  (REST API, Auth & Admin Middleware)   │
                      └───────────────────┬────────────────────┘
                                          │
                                    Mongoose ODM
                                          │
                      ┌───────────────────▼────────────────────┐
                      │               MongoDB                  │
                      │   (Products, Users, Orders, Contacts)  │
                      └────────────────────────────────────────┘
```

---

## ✨ Design Aesthetic & Color Palette

- **Signature Gold**: `#D4AF37`, `#E6CA65`, `#C59E27` (luxury champagne and yellow gold accents)
- **Deep Obsidian / Black**: `#0A0A0A`, `#121212`, `#181818` (high-contrast haute horlogerie backdrop)
- **Ivory & Cream**: `#FAF7F2`, `#F4EFEA` (elegant typography and soft accents)
- **Typography**: 
  - Headings: *Cormorant Garamond* (classical serif)
  - Body: *Montserrat* (clean, modern geometric sans)

---

## 🌟 Key Features

### Storefront Experience
- **Hero & Curated Collections**: High-impact editorial imagery showcasing Solitaire Diamonds, Rings, Necklaces, Bracelets, and Earrings.
- **Dynamic Product Catalog**: Search by keyword, filter by category and metal finish (18K Yellow Gold, 18K White Gold, Rose Gold, Platinum), filter by price range and in-stock status, with sorting (featured, price, rating, newest) and pagination.
- **Rich Product Detail Pages**: Multi-image zoom gallery, real-time stock availability, metal/ring size selectors, collapsible specifications (carat weight, GIA certification, dimensions), and related creations.
- **Persistent Shopping Bag**: Stored in `localStorage` across sessions, with quantity controls, item removals, promo code support (`FLEXI10` for 10% courtesy), and automatic luxury shipping thresholds.
- **Seamless Checkout**: Shipping address validation, insured armored courier options, and encrypted payment simulation.
- **Customer Order Archives**: View real-time status of orders (Pending, Processing, Shipped, Delivered) with tracking numbers and line-item breakdowns.
- **Bespoke Contact Inquiries**: Live contact form stored directly in MongoDB for atelier commissions and private salon appointments.

### Administrative Atelier Portal
- **Dashboard Metrics**: Real-time sales revenue, total order volume, active product count, and low-inventory replenishment alerts.
- **Product Inventory Management**: Full CRUD capabilities (create, edit, delete, adjust stock) with image URLs, specifications, and SKU tracking.
- **Order Dispatch Management**: Real-time order listing with instant status updates (`Pending` → `Processing` → `Shipped` → `Delivered` → `Cancelled`).
- **Client Inquiries**: View and mark incoming consultation requests.

---

## 🔒 Security & Business Logic

1. **Strict Server-Side Price & Total Calculation**:
   - The frontend never dictates prices, subtotal, taxes, or final totals.
   - The server fetches current product prices directly from MongoDB, multiplies by quantities, validates stock, adds tax (8%), applies conditional free shipping, and computes final totals.
2. **Stock Verification & Atomic Deduction**:
   - Orders are rejected if requested quantity exceeds database inventory stock.
   - Product stock counts are decremented upon successful order placement.
3. **Role-Based Access Control**:
   - Public user registration strictly sets `role: 'user'`. Public payloads cannot inject `role: 'admin'`.
   - Admin routes are protected on both the frontend and backend with `protect` and `adminOnly` Express middleware.
4. **Secure Password Hashing & JWT**:
   - Passwords hashed with `bcryptjs` (salt factor 10).
   - JWT tokens signed with expiration and validated via Bearer authorization headers.

---

## 🛠 Technology Stack

### Frontend
- **React 18** (Functional components, hooks)
- **React Router v6** (Client-side routing, protected routes)
- **Axios** (Configured instance with JWT interceptors)
- **Tailwind CSS & Custom Luxury CSS**
- **Lucide React** (Vector icons)
- **Vite 6** (Blazing-fast build tool)

### Backend
- **Node.js** (v20+ / v24+)
- **Express.js** (Modular REST API)
- **Mongoose 8** (Object Data Modeling)
- **JSON Web Tokens (JWT)** (Session management)
- **bcryptjs** (Password hashing)
- **CORS & Dotenv**

---

## 📁 Project Directory Structure

```
flexi/
├── backend/
│   ├── config/
│   │   └── db.js                 # MongoDB connection handler
│   ├── controllers/
│   │   ├── adminController.js    # Metrics & dashboard stats
│   │   ├── authController.js     # Register, login, profile
│   │   ├── contactController.js  # Client inquiries
│   │   ├── orderController.js    # Order creation, verification, status
│   │   └── productController.js  # Catalog CRUD, filters, search
│   ├── middleware/
│   │   ├── auth.js               # JWT verification & adminOnly guards
│   │   └── errorHandler.js       # Consistent JSON error handling
│   ├── models/
│   │   ├── Contact.js            # Inquiries schema
│   │   ├── Order.js              # Order & line items schema
│   │   ├── Product.js            # Jewelry catalog schema
│   │   └── User.js               # User accounts with bcrypt hashing
│   ├── routes/
│   │   ├── adminRoutes.js
│   │   ├── authRoutes.js
│   │   ├── contactRoutes.js
│   │   ├── healthRoutes.js       # /api/health endpoint
│   │   ├── orderRoutes.js
│   │   └── productRoutes.js
│   ├── scripts/
│   │   ├── promoteAdmin.js       # Secure CLI tool to grant admin role
│   │   ├── seed.js               # Database seeder with realistic jewelry
│   │   └── testServer.js         # Endpoint verification script
│   ├── .env                      # Local environment variables
│   ├── .env.example              # Template environment variables
│   ├── package.json
│   └── server.js                 # Express application entry point
├── frontend/
│   ├── public/
│   ├── src/
│   │   ├── components/
│   │   │   ├── AdminRoute.jsx    # Guard for administrator portal
│   │   │   ├── ErrorMessage.jsx  # Styled error banners
│   │   │   ├── Footer.jsx        # Atelier footer & trust badges
│   │   │   ├── LoadingSpinner.jsx# Gold animated spinner
│   │   │   ├── Navbar.jsx        # Navigation, bag badge, user dropdown
│   │   │   ├── ProductCard.jsx   # Interactive luxury product tile
│   │   │   └── ProtectedRoute.jsx# Guard for client account routes
│   │   ├── context/
│   │   │   ├── AuthContext.jsx   # Authentication state & actions
│   │   │   └── CartContext.jsx   # Cart state & localStorage sync
│   │   ├── pages/
│   │   │   ├── admin/
│   │   │   │   └── AdminDashboard.jsx
│   │   │   ├── About.jsx
│   │   │   ├── Cart.jsx
│   │   │   ├── Checkout.jsx
│   │   │   ├── Contact.jsx
│   │   │   ├── Home.jsx
│   │   │   ├── Login.jsx
│   │   │   ├── MyOrders.jsx
│   │   │   ├── NotFound.jsx
│   │   │   ├── ProductDetails.jsx
│   │   │   ├── Register.jsx
│   │   │   └── Shop.jsx
│   │   ├── services/
│   │   │   └── api.js            # Central Axios API service
│   │   ├── App.jsx               # Route definitions
│   │   ├── index.css             # Tailwind & luxury styling rules
│   │   └── main.jsx
│   ├── .env                      # Frontend environment variables
│   ├── .env.example
│   ├── index.html
│   ├── package.json
│   ├── postcss.config.js
│   ├── tailwind.config.js
│   └── vite.config.js
├── .gitignore
├── promote-admin.bat             # Windows shortcut to promote admin
├── run.bat                       # One-click launcher for dual dev servers
├── seed-database.bat             # Shortcut to seed database
├── start-backend.bat             # Shortcut to run Express server
├── start-frontend.bat            # Shortcut to run Vite client
└── README.md
```

---

## 🗄 Database Setup (Local & MongoDB Atlas)

Create or verify `backend/.env`:

```env
PORT=5000
NODE_ENV=development
MONGO_URI=mongodb://127.0.0.1:27017/flexi_jewelry
JWT_SECRET=flexi_luxury_jwt_secret_key_2026_super_secure
CLIENT_URL=http://localhost:5173
```

### Option A: Local MongoDB
Ensure your local MongoDB Community Server is started on port `27017`.

### Option B: MongoDB Atlas (Cloud)
1. Sign up at [MongoDB Atlas](https://www.mongodb.com/cloud/atlas).
2. Create a free M0 cluster and configure database user access.
3. Set Network Access to allow your IP (or `0.0.0.0/0` for development).
4. Copy your connection string and update `backend/.env`:
   ```env
   MONGO_URI=mongodb+srv://<username>:<password>@cluster0.mongodb.net/flexi_jewelry?retryWrites=true&w=majority
   ```

---

## 🌰 Database Seeding & Demo Accounts

To populate the catalog with 16 realistic fine jewelry pieces, admin account, customer demo account, initial sample orders, and client inquiries:

```bash
cd backend
npm run seed
```
*(Or double-click `seed-database.bat` on Windows)*

### Pre-Configured Demo Credentials:
- **Administrator Concierge**:
  - **Email**: `admin@flexijewelry.com`
  - **Password**: `Admin@123456`
  - **Role**: `admin`
- **Customer Client**:
  - **Email**: `sarah@flexijewelry.com`
  - **Password**: `Customer@123456`
  - **Role**: `user`

*(Note: The login page also provides one-click helper buttons to auto-fill these credentials for instant testing!)*

---

## 👑 Promoting an Administrator

To safely promote an existing user to administrator privileges, run the secure CLI tool:

```bash
node backend/scripts/promoteAdmin.js <user-email>
```
*(Or double-click `promote-admin.bat` and enter the email address)*

---

## 🚀 Running the Application

### Method 1: One-Click Windows Launcher
Double-click `run.bat` in the root folder. It will launch both backend (port 5000) and frontend (port 5173) in separate command windows.

### Method 2: Manual Terminal Commands

**Terminal 1 — Backend:**
```bash
cd backend
npm run start
# Server listens on http://localhost:5000
```

**Terminal 2 — Frontend:**
```bash
cd frontend
npm run dev
# Vite runs on http://localhost:5173
```

---

## 📡 REST API Endpoint Documentation

### Health Check
- `GET /api/health`: Returns service uptime and MongoDB connection state.

### Authentication
- `POST /api/auth/register`: `{ name, email, password, phone }`
- `POST /api/auth/login`: `{ email, password }`
- `GET /api/auth/me`: Returns authenticated profile (Bearer token required).
- `PUT /api/auth/profile`: Update user profile details.

### Product Catalog
- `GET /api/products`: Retrieve catalog with queries: `?page=1&limit=8&category=Rings&metal=18K Yellow Gold&keyword=diamond&sortBy=price-asc&inStock=true`
- `GET /api/products/featured`: Returns featured, best-seller, and new-arrival collections.
- `GET /api/products/:id`: Returns product details and related pieces.
- `POST /api/products`: Create product (Admin only).
- `PUT /api/products/:id`: Update product (Admin only).
- `DELETE /api/products/:id`: Remove product (Admin only).

### Orders
- `POST /api/orders`: Create order with server-side validation & stock deduction (Client only).
- `GET /api/orders/my-orders`: Retrieve logged-in client order history.
- `GET /api/orders/:id`: Retrieve single order details.
- `GET /api/orders`: Retrieve all customer orders (Admin only).
- `PUT /api/orders/:id/status`: Update order status (Admin only).

### Client Inquiries
- `POST /api/contacts`: Submit inquiry form (Public).
- `GET /api/contacts`: Retrieve inquiry messages (Admin only).
- `PUT /api/contacts/:id/status`: Mark message status (Admin only).

### Admin Metrics
- `GET /api/admin/stats`: Get aggregated revenue, order count, product count, and low-inventory warnings.

---

## 📦 Git & GitHub Deployment Status

- **Git & GitHub CLI Status**: Tested on system. `git` and `gh` executables were not found in the current Windows environment PATH.
- **Repository Preparedness**: The workspace is structured cleanly with complete `.gitignore`, environment configuration templates (`.env.example`), package dependencies, scripts, and production build verification.
- **Next Steps for GitHub Push**:
  1. Install [Git for Windows](https://git-scm.com/download/win) or [GitHub CLI](https://cli.github.com/).
  2. Open terminal in `C:\Users\HP\Downloads\flexi` and initialize:
     ```bash
     git init
     git add .
     git commit -m "feat: complete FLEXI Jewelry full-stack platform"
     ```
  3. Create your remote repository on GitHub and push:
     ```bash
     git remote add origin https://github.com/<your-username>/flexi-jewelry.git
     git branch -M main
     git push -u origin main
     ```
