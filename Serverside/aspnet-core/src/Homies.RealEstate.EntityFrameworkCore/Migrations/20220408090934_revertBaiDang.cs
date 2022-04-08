using Microsoft.EntityFrameworkCore.Migrations;

namespace Homies.RealEstate.Migrations
{
    public partial class revertBaiDang : Migration
    {
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.AlterColumn<string>(
                name: "ToaDoY",
                table: "BaiDangs",
                type: "longtext CHARACTER SET utf8mb4",
                nullable: false,
                defaultValue: "",
                oldClrType: typeof(string),
                oldType: "longtext CHARACTER SET utf8mb4",
                oldNullable: true);

            migrationBuilder.AlterColumn<string>(
                name: "ToaDoX",
                table: "BaiDangs",
                type: "longtext CHARACTER SET utf8mb4",
                nullable: false,
                defaultValue: "",
                oldClrType: typeof(string),
                oldType: "longtext CHARACTER SET utf8mb4",
                oldNullable: true);

            migrationBuilder.AddColumn<double>(
                name: "DienTich",
                table: "BaiDangs",
                type: "double",
                nullable: false,
                defaultValue: 0.0);

            migrationBuilder.AddColumn<int>(
                name: "DoUuTien",
                table: "BaiDangs",
                type: "int",
                nullable: false,
                defaultValue: 0);

            migrationBuilder.AddColumn<string>(
                name: "FeaturedImage",
                table: "BaiDangs",
                type: "longtext CHARACTER SET utf8mb4",
                nullable: false);

            migrationBuilder.AddColumn<double>(
                name: "Gia",
                table: "BaiDangs",
                type: "double",
                nullable: false,
                defaultValue: 0.0);
        }

        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropColumn(
                name: "DienTich",
                table: "BaiDangs");

            migrationBuilder.DropColumn(
                name: "DoUuTien",
                table: "BaiDangs");

            migrationBuilder.DropColumn(
                name: "FeaturedImage",
                table: "BaiDangs");

            migrationBuilder.DropColumn(
                name: "Gia",
                table: "BaiDangs");

            migrationBuilder.AlterColumn<string>(
                name: "ToaDoY",
                table: "BaiDangs",
                type: "longtext CHARACTER SET utf8mb4",
                nullable: true,
                oldClrType: typeof(string),
                oldType: "longtext CHARACTER SET utf8mb4");

            migrationBuilder.AlterColumn<string>(
                name: "ToaDoX",
                table: "BaiDangs",
                type: "longtext CHARACTER SET utf8mb4",
                nullable: true,
                oldClrType: typeof(string),
                oldType: "longtext CHARACTER SET utf8mb4");
        }
    }
}
