
<!-- PROJECT LOGO -->
<br />
<p align="center">
  <a href="https://github.com/MinhTran0311/HomiesRealEstate">
    <img src="https://github.com/MinhTran0311/HomiesRealEstate/blob/main/Clientside/flutter/assets/icons/ic_appicon.png" alt="Logo" width="200" height="200">
  </a>

  <h3 align="center">Homies Real Estate</h3>

  <p align="center">
    Ứng dụng Homies Real Estate cung cấp nền tảng cho phép người dùng chia sẻ các thông tin mua bán, cho thuê các bất động sản. Đặc biệt, các thông tin quan trọng về bất động sản đều được thể hiện một cách rõ ràng tạo điều kiện thuận lợi nhất cho giao dịch.
    <br />
    <a href="https://github.com/MinhTran0311/HomiesRealEstate"><strong>Explore the docs »</strong></a>
    <br />
    <br />
    <a href="https://play.google.com/store/apps/details?id=com.homies.realestate">View Demo</a>
    ·
    <a href="https://github.com/MinhTran0311/HomiesRealEstate/issues">Report Bug</a>
    ·
    <a href="https://github.com/MinhTran0311/HomiesRealEstate/issues">Request Feature</a>
  </p>
</p>



<!-- TABLE OF CONTENTS -->
<details open="open">
  <summary><h2 style="display: inline-block">Table of Contents</h2></summary>
  <ol>
    <li>
      <a href="#about-the-project">About The Project</a>
      <ul>
        <li><a href="#built-with">Built With</a></li>
      </ul>
    </li>
    <li>
      <a href="#getting-started">Getting Started</a>
      <ul>
        <li><a href="#prerequisites">Prerequisites</a></li>
        <li><a href="#installation">Installation</a></li>
      </ul>
    </li>
    <li><a href="#architecture">Architecture & Database</a></li>
    <li><a href="#contact">Contact</a></li>
    <li><a href="#techstack">Tech Stacks</a></li>
  </ol>
</details>



<!-- ABOUT THE PROJECT -->
## About The Project

1. Introduction
Ứng dụng Homies Real Estate cung cấp nền tảng cho phép người dùng chia sẻ các thông tin mua bán, cho thuê các bất động sản. Đặc biệt, các thông tin quan trọng về bất động sản đều được thể hiện một cách rõ ràng tạo điều kiện thuận lợi nhất cho giao dịch.

2. Features
- 

### Built With

* [ASPNET Zero](https://aspnetzero.com/)
* [Flutter](https://flutter.dev/)



<!-- GETTING STARTED -->
## Getting Started

To get a local copy up and running follow these simple steps.

### Prerequisites
1. Software
* flutter 1.22.6
  ```Powershell
  choco install flutter --version=1.22.6
  ```
  
2. Hardware
* For development
- Operating system: Windows 10
- DBMS: MariaDb 10
- Testing environment: Xiaomi Note 4X, Xiaomi Note 7 pro, Pixel 3 (Emulator)
	
* For Deployment
- Operating System: Android 5+
- RAM: 2GB
CPU: Snapdragon 439 / MediaTek MT6762 (P22) or higher
- Storage: 200MB

### Installation
* For Flutter App
1. Clone the repo
   ```sh
   git clone https://github.com/MinhTran0311/HomiesRealEstate_name.git
   ```
2. Install required library
   ```cmd
   cd Clientside/flutter
   flutter pub get
   ```
3. Auto Inject file
   ```cmd
   flutter packages pub run build_runner build --delete-conflicting-outputs
   ```
4. Run the App on Emulator


<!-- Architecture -->
## architecture
1. Database
<p align="center">
  <a href="https://github.com/MinhTran0311/HomiesRealEstate">
    <img src="https://github.com/MinhTran0311/HomiesRealEstate/blob/main/database.png" alt="Logo" width="900" height="700">
  </a>

  <h3 align="center">Homies Real Estate</h3>
</p>
2. Architecture
<p align="center">
  <a href="https://github.com/MinhTran0311/HomiesRealEstate">
    <img src="https://github.com/MinhTran0311/HomiesRealEstate/blob/main/architecture.png" alt="Logo" width="500" height="200">
  </a>

  <h3 align="center">Homies Real Estate</h3>
</p>

Hệ thống sử dụng kiến trúc client-server ứng dụng Angular Solution, ASP.NET Solution và giao thức API để trao đổi thông tin.
* Flutter App
Flutter App là một ứng dụng Flutter thuần tuý có thể hoạt động độc lập trên Android, iOS. Kết nối với Server thông qua RESTful API.
* ASP.NET Zero
Trong kiến trúc ASP.NET Core Solution không có sự xuất hiện code của HTML, JS hoặc CSS. Nó chỉ đơn giản cung cấp điểm cuối để xác thực dựa trên mã token và sử dụng các application services (API REST).
Bên trong ASP.NET Core Solution, các thành phần được xây dựng dựa trên nguyên tắc SOLID:
-	Single Responsibilty Priciple (SRP): mỗi class chỉ nên giữ 1 trách nhiệm duy nhất và một lớp chỉ có một, và chỉ một lý do để thay đổi.
-	Open/Closed Priciple (OCP):  Có thể thoải mái mở rộng 1 class, nhưng không được thay đổi bên trong class đó.
-	LiskovSubsitution Priciple (LSP): Trong một chương trình, các object của class con có thể thay thế class cha mà không làm thay đổi tính đúng đắn của chương trình.
-	Interface Segregation Priciple (ISP): Thay vì dùng 1 interface lớn, ta nên tách thành nhiều interface nhỏ, với nhiều mục đích cụ thể
-	Dependency Inversion Priciple (DIP): 
Các module cấp cao không nên phụ thuộc vào các modules cấp thấp. Cả 2 nên phụ thuộc vào abstraction.
Interface (abstraction) không nên phụ thuộc vào chi tiết, mà ngược lại (các class giao tiếp với nhau thông qua interface, không phải thông qua implementation).


<!-- CONTACT -->
## Contact

-Nguyễn Minh Đức - [@nmd11999](https://twitter.com/nmd11999) - email: ictnmd@gmail.com
-Trần Tuấn Minh - [@nmd11999](https://twitter.com/nmd11999) - email: 18520314@gm.uit.edu.vn
-Phạm Quốc Đạt - [@nmd11999](https://twitter.com/nmd11999) - email: 18520584@gm.uit.edu.vn
-Nguyễn Văn Dương - [@nmd11999](https://twitter.com/nmd11999) - email: 18520211@gm.uit.edu.vn
-Nguyễn Văn Lương - [@nmd11999](https://twitter.com/nmd11999) - email: 18520096@gm.uit.edu.vn

Project Link: [https://github.com/MinhTran0311/HomiesRealEstate_name](https://github.com/MinhTran0311/HomiesRealEstate_name)



<!-- Tech Stacks -->
## Techstack

- ASP.NET Zero
- Flutter
- MariaDb
- IdentityServer
- JWT
- Dio
- Database
- MobX (to connect the reactive data of your application with the UI)
- Provider (State Management)
- Encryption
- Validation
- Logging
- Notifications
- Json Serialization
- Dependency Injection
