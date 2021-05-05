using Microsoft.EntityFrameworkCore.Migrations;

namespace Homies.RealEstate.Migrations
{
    public partial class a : Migration
    {
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.AddColumn<double>(
                name: "DienTich",
                table: "BaiDangs",
                type: "double",
                nullable: false,
                defaultValue: 0.0);

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
                name: "FeaturedImage",
                table: "BaiDangs");

            migrationBuilder.DropColumn(
                name: "Gia",
                table: "BaiDangs");
        }
    }
}
