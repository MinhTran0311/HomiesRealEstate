import { Injectable } from '@angular/core';
import { AppLocalizationService } from '@app/shared/common/localization/app-localization.service';
import { DateTime } from 'luxon';

@Injectable()
export class DateTimeService {

    constructor(private _appLocalizationService: AppLocalizationService) {

    }

    createDateRangePickerOptions(): any {
        let options = {
            locale: {
                format: 'L',
                applyLabel: this._appLocalizationService.l('Apply'),
                cancelLabel: this._appLocalizationService.l('Cancel'),
                customRangeLabel: this._appLocalizationService.l('CustomRange')
            },
            min: this.fromISODateString('2015-05-01'),
            minDate: this.fromISODateString('2015-05-01'),
            max: this.getDate(),
            maxDate: this.getDate(),
            opens: 'left',
            ranges: {}
        };

        options.ranges[this._appLocalizationService.l('Today')] = [this.getStartOfDay(), this.getEndOfDay()];
        options.ranges[this._appLocalizationService.l('Yesterday')] = [this.minusDays(this.getStartOfDay(), 1), this.minusDays(this.getEndOfDay(), 1)];
        options.ranges[this._appLocalizationService.l('Last7Days')] = [this.minusDays(this.getStartOfDay(), 6), this.getEndOfDay()];
        options.ranges[this._appLocalizationService.l('Last30Days')] = [this.minusDays(this.getStartOfDay(), 29), this.getEndOfDay()];
        options.ranges[this._appLocalizationService.l('ThisMonth')] = [this.getDate().startOf('month'), this.getDate().endOf('month')];
        options.ranges[this._appLocalizationService.l('LastMonth')] = [this.getDate().startOf('month').minus({ months: 1 }), this.getDate().endOf('month').minus({ months: 1 })];

        return options;
    }

    getDate(): DateTime {
        if (abp.clock.provider.supportsMultipleTimezone) {
            return DateTime.local().setZone(abp.timing.timeZoneInfo.iana.timeZoneId);
        } else {
            return DateTime.local();
        }
    }

    getUTCDate(): DateTime {
        return DateTime.utc();
    }

    getYear(): number {
        return this.getDate().year;
    }

    getStartOfDay(): DateTime {
        return this.getDate().startOf('day');
    }

    getStartOfDayForDate(date: DateTime | Date): DateTime {
        if (!date) {
            return date as DateTime;
        }

        if (date instanceof Date) {
            return this.getStartOfDayForDate(this.fromJSDate(date));
        }

        return date.startOf('day');
    }

    getStartOfDayMinusDays(daysFromNow: number): DateTime {
        let date = this.getDate();
        let newDate = this.minusDays(date, daysFromNow);
        return this.getEndOfDayForDate(newDate);
    }

    getEndOfDay(): DateTime {
        return this.getDate().endOf('day');
    }

    getEndOfDayForDate(date: DateTime | Date): DateTime {
        if (!date) {
            return date as DateTime;
        }

        if (date instanceof Date) {
            return this.getEndOfDayForDate(this.fromJSDate(date));
        }

        return date.endOf('day');
    }

    getEndOfDayPlusDays(daysFromNow: number): DateTime {
        let date = this.getDate();
        let newDate = this.plusDays(date, daysFromNow);
        return this.getEndOfDayForDate(newDate);
    }

    getEndOfDayMinusDays(daysFromNow: number): DateTime {
        let date = this.getDate();
        let newDate = this.minusDays(date, daysFromNow);
        return this.getEndOfDayForDate(newDate);
    }

    plusDays(date: DateTime | Date, dayCount: number): DateTime {
        if (date instanceof Date) {
            return this.plusDays(this.fromJSDate(date), dayCount);
        }

        return date.plus({ days: dayCount });
    }

    plusSeconds(date: DateTime, seconds: number) {
        if (!date) {
            return date;
        }

        if (date instanceof Date) {
            return this.plusSeconds(this.fromJSDate(date), seconds);
        }

        return date.plus({ seconds: seconds });
    }

    minusDays(date: DateTime, dayCount: number): DateTime {
        return date.minus({ days: dayCount });
    }

    fromISODateString(date: string): DateTime {
        return DateTime.fromISO(date);
    }

    formatISODateString(dateText: string, format: string): string {
        let date = this.fromISODateString(dateText);
        return date.toFormat(format);
    }

    formatJSDate(jsDate: Date, format: string): string {
        let date = DateTime.fromJSDate(jsDate);
        return date.toFormat(format);
    }

    formatDate(date: DateTime | Date, format: string): string {
        if (date instanceof Date) {
            return this.formatDate(this.fromJSDate(date), format);
        }

        return date.toFormat(format);
    }

    getDiffInSeconds(maxDate: DateTime | Date, minDate: DateTime | Date) {
        if (maxDate instanceof Date && minDate instanceof Date) {
            return this.getDiffInSeconds(this.fromJSDate(maxDate), this.fromJSDate(minDate));
        }

        return (maxDate as DateTime).diff(minDate as DateTime, 'seconds');
    }

    createJSDate(year: number, month: number, day: number): Date {
        return this.createDate(year, month, day).toJSDate();
    }

    createDate(year: number, month: number, day: number): DateTime {
        if (abp.clock.provider.supportsMultipleTimezone) {
            return DateTime.utc(year, month + 1, day);
        } else {
            return DateTime.local(year, month + 1, day);
        }
    }

    createUtcDate(year: number, month: number, day: number): DateTime {
        return DateTime.utc(year, month + 1, day);
    }

    toUtcDate(date: DateTime | Date): any {
        if (date instanceof Date) {
            return this.createUtcDate(date.getFullYear(), date.getMonth(), date.getDate()).toJSDate();
        }

        return this.createUtcDate(date.year, date.month, date.day);
    }

    fromJSDate(date: Date): DateTime {
        return DateTime.fromJSDate(date);
    }

    fromNow(date: DateTime | Date): string {
        if (date instanceof Date) {
            return this.fromNow(this.fromJSDate(date));
        }

        return date.toRelative();
    }
}
