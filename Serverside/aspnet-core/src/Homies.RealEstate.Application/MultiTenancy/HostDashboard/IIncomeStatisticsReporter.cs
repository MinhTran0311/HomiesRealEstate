using System;
using System.Collections.Generic;
using System.Threading.Tasks;
using Homies.RealEstate.MultiTenancy.HostDashboard.Dto;

namespace Homies.RealEstate.MultiTenancy.HostDashboard
{
    public interface IIncomeStatisticsService
    {
        Task<List<IncomeStastistic>> GetIncomeStatisticsData(DateTime startDate, DateTime endDate,
            ChartDateInterval dateInterval);
    }
}