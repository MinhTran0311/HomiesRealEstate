using System;
using Microsoft.EntityFrameworkCore.Metadata;
using Microsoft.EntityFrameworkCore.Migrations;

namespace Homies.RealEstate.Migrations
{
    public partial class Regenerated_BaiDang1177 : Migration
    {
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.CreateTable(
                name: "BaiDangs",
                columns: table => new
                {
                    Id = table.Column<int>(type: "int", nullable: false)
                        .Annotation("MySql:ValueGenerationStrategy", MySqlValueGenerationStrategy.IdentityColumn),
                    TagLoaiBaiDang = table.Column<string>(type: "varchar(25) CHARACTER SET utf8mb4", maxLength: 25, nullable: false),
                    ThoiDiemDang = table.Column<DateTime>(type: "datetime(6)", nullable: false),
                    ThoiHan = table.Column<DateTime>(type: "datetime(6)", nullable: false),
                    DiaChi = table.Column<string>(type: "varchar(100) CHARACTER SET utf8mb4", maxLength: 100, nullable: false),
                    MoTa = table.Column<string>(type: "varchar(1000) CHARACTER SET utf8mb4", maxLength: 1000, nullable: false),
                    ToaDoX = table.Column<string>(type: "longtext CHARACTER SET utf8mb4", nullable: false),
                    ToaDoY = table.Column<string>(type: "longtext CHARACTER SET utf8mb4", nullable: false),
                    LuotXem = table.Column<int>(type: "int", nullable: true),
                    LuotYeuThich = table.Column<int>(type: "int", nullable: true),
                    DiemBaiDang = table.Column<decimal>(type: "decimal(65,30)", nullable: true),
                    TrangThai = table.Column<string>(type: "varchar(25) CHARACTER SET utf8mb4", maxLength: 25, nullable: false),
                    TagTimKiem = table.Column<string>(type: "longtext CHARACTER SET utf8mb4", nullable: true),
                    TieuDe = table.Column<string>(type: "varchar(50) CHARACTER SET utf8mb4", maxLength: 50, nullable: false),
                    UserId = table.Column<long>(type: "bigint", nullable: true),
                    DanhMucId = table.Column<int>(type: "int", nullable: true),
                    XaId = table.Column<int>(type: "int", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_BaiDangs", x => x.Id);
                    table.ForeignKey(
                        name: "FK_BaiDangs_AbpUsers_UserId",
                        column: x => x.UserId,
                        principalTable: "AbpUsers",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Restrict);
                    table.ForeignKey(
                        name: "FK_BaiDangs_DanhMucs_DanhMucId",
                        column: x => x.DanhMucId,
                        principalTable: "DanhMucs",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Restrict);
                    table.ForeignKey(
                        name: "FK_BaiDangs_Xas_XaId",
                        column: x => x.XaId,
                        principalTable: "Xas",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Restrict);
                });

            migrationBuilder.CreateIndex(
                name: "IX_BaiDangs_DanhMucId",
                table: "BaiDangs",
                column: "DanhMucId");

            migrationBuilder.CreateIndex(
                name: "IX_BaiDangs_UserId",
                table: "BaiDangs",
                column: "UserId");

            migrationBuilder.CreateIndex(
                name: "IX_BaiDangs_XaId",
                table: "BaiDangs",
                column: "XaId");
        }

        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropTable(
                name: "BaiDangs");
        }
    }
}
