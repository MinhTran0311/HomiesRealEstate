using System;
using Microsoft.EntityFrameworkCore.Migrations;

namespace Homies.RealEstate.Migrations
{
    public partial class Added_ChiTietHoaDonBaiDang : Migration
    {
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.CreateTable(
                name: "ChiTietHoaDonBaiDangs",
                columns: table => new
                {
                    Id = table.Column<Guid>(type: "char(36)", nullable: false),
                    ThoiDiem = table.Column<DateTime>(type: "datetime(6)", nullable: false),
                    GiaGoi = table.Column<double>(type: "double", nullable: false),
                    SoNgayMua = table.Column<int>(type: "int", nullable: false),
                    TongTien = table.Column<double>(type: "double", nullable: false),
                    GhiChu = table.Column<string>(type: "varchar(50) CHARACTER SET utf8mb4", maxLength: 50, nullable: false),
                    BaiDangId = table.Column<int>(type: "int", nullable: true),
                    GoiBaiDangId = table.Column<int>(type: "int", nullable: true),
                    UserId = table.Column<long>(type: "bigint", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_ChiTietHoaDonBaiDangs", x => x.Id);
                    table.ForeignKey(
                        name: "FK_ChiTietHoaDonBaiDangs_AbpUsers_UserId",
                        column: x => x.UserId,
                        principalTable: "AbpUsers",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Restrict);
                    table.ForeignKey(
                        name: "FK_ChiTietHoaDonBaiDangs_BaiDangs_BaiDangId",
                        column: x => x.BaiDangId,
                        principalTable: "BaiDangs",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Restrict);
                    table.ForeignKey(
                        name: "FK_ChiTietHoaDonBaiDangs_GoiBaiDangs_GoiBaiDangId",
                        column: x => x.GoiBaiDangId,
                        principalTable: "GoiBaiDangs",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Restrict);
                });

            migrationBuilder.CreateIndex(
                name: "IX_ChiTietHoaDonBaiDangs_BaiDangId",
                table: "ChiTietHoaDonBaiDangs",
                column: "BaiDangId");

            migrationBuilder.CreateIndex(
                name: "IX_ChiTietHoaDonBaiDangs_GoiBaiDangId",
                table: "ChiTietHoaDonBaiDangs",
                column: "GoiBaiDangId");

            migrationBuilder.CreateIndex(
                name: "IX_ChiTietHoaDonBaiDangs_UserId",
                table: "ChiTietHoaDonBaiDangs",
                column: "UserId");
        }

        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropTable(
                name: "ChiTietHoaDonBaiDangs");
        }
    }
}
