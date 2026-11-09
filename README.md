# Warehouse Inventory Manager (macOS Native App)

A native macOS desktop application built with **SwiftUI**, developed as an independent project to explore macOS application architecture, state management, and clean user experience flows. 

*(Note: This is an ongoing MVP project built to test native macOS development principles and expand my software engineering skillset.)*

---

## 🚀 Application Architecture & Current UX Flow

The app guides users through a multi-view state machine:

1. **Splash View (`SplashView`):**
   * Features a dynamic gradient background (`indigo` to `purple` to `pink` spanning top-leading to bottom-trailing) with ignored safe areas.
   * Styled with custom *American Typewriter* typography.
   * Programmatically timed to transition smoothly after 3 seconds to avoid perceived app lag.

2. **Welcome View (`WelcomeView`):**
   * Light-mode optimized onboarding view welcoming users into the system loop.

3. **Launch Dashboard (`LaunchDashboardView`):**
   * Acts as the central landing hub, featuring system branding and navigation into warehouse operations.

4. **Warehouse Manager (`WarehouseManagerView`):**
   * **Central Control Hub:** Displays live stock data (initialized with a baseline inventory of 3 default stock items for demonstration).
   * **Product Registration:** Allows users to add new items by description and price, dynamically appending them to the state array and incrementing the total stock counter.
   * **Code-Based Search Bar:** Fast filtering tailored specifically to product codes.

5. **Item Detail View (`ItemDetailView`):**
   * Triggered by tapping any item from the main inventory list.
   * Renders deep-dive data including bolded item codes, descriptive metadata, and the item's **Financial Asset Value**.

---

## 🛠️ Tech Stack & Concepts
* **Language:** Swift
* **Framework:** SwiftUI (macOS App Lifecycle target)
* **Design Patterns:** Declarative UI routing, state binding (`@State`), view composition, and state-driven list manipulation.

---

## 🚧 Known Faults & Future Roadmap
Because this project is a continuous learning experience, several improvements and features are planned for future iterations:
* **Dark Mode Support:** Full integration of system appearance adaptations (currently optimized for light mode).
* **Administrative Authentication:** Implementing password-gated access control on the dashboard to restrict inventory management to authorized system administrators.
* **Flexible Error Handling & Editing:** Refactoring the item-editing logic to allow safe modification/rerouting of item codes to accommodate user-entry errors and administrative changes rather than locking them permanently.
* **Accessibility Enhancements:** Improving color contrast, screen-reader labeling, and overall UI accessibility standards.
