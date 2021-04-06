using System;
using Microsoft.EntityFrameworkCore.Migrations;

namespace Homies.RealEstate.Migrations
{
    public partial class Added_LichSuGiaoDich : Migration
    {
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.CreateTable(
                name: "LichSuGiaoDichs",
                columns: table => new
                {
                    Id = table.Column<Guid>(type: "char(36)", nullable: false),
                    SoTien = table.Column<double>(type: "double", nullable: false),
                    ThoiDiem = table.Column<DateTime>(type: "datetime(6)", nullable: false),
                    GhiChu = table.Column<string>(type: "varchar(50) CHARACTER SET utf8mb4", maxLength: 50, nullable: false),
                    UserId = table.Column<long>(type: "bigint", nullable: true),
                    ChiTietHoaDonBaiDangId = table.Column<Guid>(type: "char(36)", nullable: true),
                    KiemDuyetVienId = table.Column<long>(type: "bigint", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_LichSuGiaoDichs", x => x.Id);
                    table.ForeignKey(
                        name: "FK_LichSuGiaoDichs_AbpUsers_KiemDuyetVienId",
                        column: x => x.KiemDuyetVienId,
                        principalTable: "AbpUsers",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Restrict);
                    table.ForeignKey(
                        name: "FK_LichSuGiaoDichs_AbpUsers_UserId",
                        column: x => x.UserId,
                        principalTable: "AbpUsers",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Restrict);
                    table.ForeignKey(
                        name: "FK_LichSuGiaoDichs_ChiTietHoaDonBaiDangs_ChiTietHoaDonBaiDangId",
                        column: x => x.ChiTietHoaDonBaiDangId,
                        principalTable: "ChiTietHoaDonBaiDangs",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Restrict);
                });

            migrationBuilder.CreateIndex(
                name: "IX_LichSuGiaoDichs_ChiTietHoaDonBaiDangId",
                table: "LichSuGiaoDichs",
                column: "ChiTietHoaDonBaiDangId");

            migrationBuilder.CreateIndex(
                name: "IX_LichSuGiaoDichs_KiemDuyetVienId",
                table: "LichSuGiaoDichs",
                column: "KiemDuyetVienId");

            migrationBuilder.CreateIndex(
                name: "IX_LichSuGiaoDichs_UserId",
                table: "LichSuGiaoDichs",
                column: "UserId");
        }

        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropTable(
                name: "LichSuGiaoDichs");
        }
    }
}
