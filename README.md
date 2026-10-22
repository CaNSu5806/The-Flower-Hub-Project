# The Flower Hub – Multi-Vendor Gift & Flower Delivery System

## Project Overview

The Flower Hub is a multi-vendor gift and flower delivery database system connecting shops, customers, and couriers.
The system is designed using **Oracle SQL** and follows **3NF normalization** principles.

The goal is to maintain:

* Data integrity
* Relational consistency
* Transaction reliability
* Scalable schema design

---

## System Roles

* Customer – browses flowers and gifts
* Vendor / Shop Owner – manages products
* Courier – handles deliveries
* Admin – system management

---

## Core Entities

* Users
* Roles
* Shops
* Categories
* Products
* Orders
* OrderDetails
* Reviews
* Coupons
* Payments
* InventoryLogs

---

## Database Features

* One-to-Many relationships
* Many-to-Many relationships
* Oracle SQL Triggers
* PL/SQL Procedures
* Views for reporting
* 3NF Normalization

---

## Team Members

| Member         | Role                  |
| -------------- | --------------------- |
| Mustafa CAN    | User Management       |
| Leen SUBH      | Shop & Catalog        |
| Cansu COŞKUN   | Product & Inventory   |
| Esma ARICI     | Orders & Transactions |
| Zeynep ÖZBUDAK | Reviews & Promotions  |

---

## Database Structure

Users → Orders → OrderDetails → Products
Shops → Products
Users → Reviews

---

This repository contains the collaborative database design for **The Flower Hub** system.
