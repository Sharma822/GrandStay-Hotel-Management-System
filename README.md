# GrandStay: Enterprise Hotel Reservation & Inventory Management System

An enterprise-grade, multi-tier web application built with **Jakarta EE**, **Hibernate ORM**, and **MySQL** for end-to-end hotel room inventory tracking, dynamic guest tariff calculations, and administrative management.

---

## 🚀 Key Features

* **Real-Time Booking Engine:** Public customer portal with dynamic night-count and tariff estimation calculators.
* **Room Inventory Control:** Real-time room status indicators (`AVAILABLE` / `BOOKED`) preventing overbooking.
* **Administrative Control Deck:** Secure admin authentication to manage, add, update, and inspect room inventories and customer reservations.
* **Hibernate ORM Persistence:** Complete entity-relational mapping using Hibernate 6 and Jakarta Persistence API (JPA) for automated schema handling and query execution.
* **Responsive UI:** Clean, modern dashboard interface optimized for intuitive reservation workflows.

---

## 🛠️ Tech Stack & Architecture

* **Backend:** Java (Jakarta EE 10, Jakarta Servlets, JSP)
* **ORM / Persistence:** Hibernate 6, Jakarta Persistence API (JPA)
* **Database:** MySQL Server
* **Build Tool:** Apache Maven
* **Server Runtime:** Apache Tomcat 10+
* **Frontend:** Modern HTML5, CSS3, JSP Expression Language (EL)

---

## 📁 Project Architecture

```text
HotelBookingSystem/
├── src/
│   └── main/
│       ├── java/
│       │   └── com/hotel/
│       │       ├── dao/        # Data Access Layer (HotelDAO.java)
│       │       ├── entity/     # JPA Entities (Room, Customer, Booking)
│       │       ├── servlet/    # Controllers (RoomServlet, BookingServlet, AdminAuthServlet)
│       │       └── util/       # Hibernate Configuration (HibernateUtil.java)
│       ├── resources/          # hibernate.cfg.xml, persistence.xml
│       └── webapp/             # JSP views (index.jsp, rooms.jsp, admin-login.jsp, etc.)
└── pom.xml                     # Maven project dependencies
