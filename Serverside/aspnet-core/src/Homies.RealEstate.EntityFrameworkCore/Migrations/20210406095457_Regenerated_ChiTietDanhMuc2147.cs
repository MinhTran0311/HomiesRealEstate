using Microsoft.EntityFrameworkCore.Metadata;
using Microsoft.EntityFrameworkCore.Migrations;

namespace Homies.RealEstate.Migrations
{
    public partial class Regenerated_ChiTietDanhMuc2147 : Migration
    {
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.CreateTable(
                name: "ChiTietDanhMucs",
                columns: table => new
                {
                    Id = table.Column<int>(type: "int", nullable: false)
                        .Annotation("MySql:ValueGenerationStrategy", MySqlValueGenerationStrategy.IdentityColumn),
                    GhiChu = table.Column<string>(type: "varchar(50) CHARACTER SET utf8mb4", maxLength: 50, nullable: true),
                    ThuocTinhId = table.Column<int>(type: "int", nullable: true),
                    DanhMucId = table.Column<int>(type: "int", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_ChiTietDanhMucs", x => x.Id);
                    table.ForeignKey(
                        name: "FK_ChiTietDanhMucs_DanhMucs_DanhMucId",
                        column: x => x.DanhMucId,
                        principalTable: "DanhMucs",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Restrict);
                    table.ForeignKey(
                        name: "FK_ChiTietDanhMucs_ThuocTinhs_ThuocTinhId",
                        column: x => x.ThuocTinhId,
                        principalTable: "ThuocTinhs",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Restrict);
                });

            migrationBuilder.CreateIndex(
                name: "IX_ChiTietDanhMucs_DanhMucId",
                table: "ChiTietDanhMucs",
                column: "DanhMucId");

            migrationBuilder.CreateIndex(
                name: "IX_ChiTietDanhMucs_ThuocTinhId",
                table: "ChiTietDanhMucs",
                column: "ThuocTinhId");
        }

        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropTable(
                name: "ChiTietDanhMucs");
        }
    }
}
