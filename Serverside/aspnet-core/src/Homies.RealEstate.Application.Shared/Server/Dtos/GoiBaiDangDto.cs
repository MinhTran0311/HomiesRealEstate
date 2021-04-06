using System;
using Abp.Application.Services.Dto;

namespace Homies.RealEstate.Server.Dtos
{
    public class GoiBaiDangDto : EntityDto
    {
        public string TenGoi { get; set; }

        public double Phi { get; set; }

        public int DoUuTien { get; set; }

        public int ThoiGianToiThieu { get; set; }

        public string MoTa { get; set; }

        public string TrangThai { get; set; }

    }
}