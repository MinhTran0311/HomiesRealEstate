using Microsoft.EntityFrameworkCore.Metadata;
using Microsoft.EntityFrameworkCore.Migrations;

namespace Homies.RealEstate.Migrations
{
    public partial class Added_ChiTietBaiDang : Migration
    {
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.CreateTable(
                name: "ChiTietBaiDangs",
                columns: table => new
                {
                    Id = table.Column<int>(type: "int", nullable: false)
                        .Annotation("MySql:ValueGenerationStrategy", MySqlValueGenerationStrategy.IdentityColumn),
                    GiaTri = table.Column<string>(type: "longtext CHARACTER SET utf8mb4", nullable: false),
                    ThuocTinhId = table.Column<int>(type: "int", nullable: true),
                    BaiDangId = table.Column<int>(type: "int", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_ChiTietBaiDangs", x => x.Id);
                    table.ForeignKey(
                        name: "FK_ChiTietBaiDangs_BaiDangs_BaiDangId",
                        column: x => x.BaiDangId,
                        principalTable: "BaiDangs",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Restrict);
                    table.ForeignKey(
                        name: "FK_ChiTietBaiDangs_ThuocTinhs_ThuocTinhId",
                        column: x => x.ThuocTinhId,
                        principalTable: "ThuocTinhs",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Restrict);
                });

            migrationBuilder.CreateIndex(
                name: "IX_ChiTietBaiDangs_BaiDangId",
                table: "ChiTietBaiDangs",
                column: "BaiDangId");

            migrationBuilder.CreateIndex(
                name: "IX_ChiTietBaiDangs_ThuocTinhId",
                table: "ChiTietBaiDangs",
                column: "ThuocTinhId");
        }

        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropTable(
                name: "ChiTietBaiDangs");
        }
    }
}
