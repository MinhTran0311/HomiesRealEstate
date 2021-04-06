using System;
using Microsoft.EntityFrameworkCore.Metadata;
using Microsoft.EntityFrameworkCore.Migrations;

namespace Homies.RealEstate.Migrations
{
    public partial class Regenerated_BaiGhimYeuThich6366 : Migration
    {
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.CreateTable(
                name: "BaiGhimYeuThichs",
                columns: table => new
                {
                    Id = table.Column<int>(type: "int", nullable: false)
                        .Annotation("MySql:ValueGenerationStrategy", MySqlValueGenerationStrategy.IdentityColumn),
                    ThoiGian = table.Column<DateTime>(type: "datetime(6)", nullable: false),
                    TrangThai = table.Column<string>(type: "varchar(25) CHARACTER SET utf8mb4", maxLength: 25, nullable: false),
                    UserId = table.Column<long>(type: "bigint", nullable: true),
                    BaiDangId = table.Column<int>(type: "int", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_BaiGhimYeuThichs", x => x.Id);
                    table.ForeignKey(
                        name: "FK_BaiGhimYeuThichs_AbpUsers_UserId",
                        column: x => x.UserId,
                        principalTable: "AbpUsers",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Restrict);
                    table.ForeignKey(
                        name: "FK_BaiGhimYeuThichs_BaiDangs_BaiDangId",
                        column: x => x.BaiDangId,
                        principalTable: "BaiDangs",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Restrict);
                });

            migrationBuilder.CreateIndex(
                name: "IX_BaiGhimYeuThichs_BaiDangId",
                table: "BaiGhimYeuThichs",
                column: "BaiDangId");

            migrationBuilder.CreateIndex(
                name: "IX_BaiGhimYeuThichs_UserId",
                table: "BaiGhimYeuThichs",
                column: "UserId");
        }

        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropTable(
                name: "BaiGhimYeuThichs");
        }
    }
}
