using System;
using Abp.Notifications;
using Homies.RealEstate.Dto;

namespace Homies.RealEstate.Notifications.Dto
{
    public class GetUserNotificationsInput : PagedInputDto
    {
        public UserNotificationState? State { get; set; }

        public DateTime? StartDate { get; set; }

        public DateTime? EndDate { get; set; }
    }
}