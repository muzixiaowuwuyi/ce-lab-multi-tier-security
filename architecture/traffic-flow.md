# Traffic Flow Analysis

This document outlines the end-to-end communication paths within the multi-tier architecture.

## 1. End-User Traffic (Business Flow)
| Source | Destination | Protocol/Port | Description |
| :--- | :--- | :--- | :--- |
| Public Internet | CE-Web-SG | HTTP (80) / HTTPS (443) | Users access the website via a browser. |
| CE-Web-SG | CE-App-SG | TCP (8080) | Web servers forward application requests to the backend. |
| CE-App-SG | CE-DB-SG | MySQL (3306) | Application servers query or update the database. |

## 2. Administrative Traffic (Management Flow)
| Source | Destination | Protocol/Port | Description |
| :--- | :--- | :--- | :--- |
| Developer Home IP | CE-Bastion-SG | SSH (22) | Initial secure connection to the cloud environment. |
| CE-Bastion-SG | CE-Web-SG | SSH (22) | Internal jump to manage web servers. |
| CE-Bastion-SG | CE-App-SG | SSH (22) | Internal jump to manage application servers. |
| CE-Bastion-SG | CE-DB-SG | SSH (22) | Internal jump for database maintenance (if required). |

