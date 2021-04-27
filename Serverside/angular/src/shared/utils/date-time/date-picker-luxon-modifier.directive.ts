import { Directive, Self, Output, EventEmitter, Input, SimpleChanges, OnDestroy, OnChanges } from '@angular/core';
import { BsDatepickerDirective } from 'ngx-bootstrap/datepicker';
import { Subscription } from 'rxjs';
import { DateTime } from 'luxon';
import compare from 'just-compare';
import { DateTimeService } from '@app/shared/common/timing/date-time.service';

///this directive ensures that the date value will always be the luxon.
@Directive({
    selector: '[datePickerLuxonModifier]'
})
export class DatePickerLuxonModifierDirective implements OnDestroy, OnChanges {
    @Input() date = new EventEmitter();
    @Output() dateChange = new EventEmitter();

    subscribe: Subscription;
    lastDate: Date = null;

    constructor(
        @Self() private bsDatepicker: BsDatepickerDirective,
        private _dateTimeService: DateTimeService
    ) {
        this.subscribe = bsDatepicker.bsValueChange
            .subscribe((date: Date) => {
                if (!date) {
                    this.lastDate = null;
                    this.dateChange.emit(null);
                } else if ((date instanceof Date && !compare(this.lastDate, date) && date.toString() !== 'Invalid Date')) {
                    this.lastDate = date;
                    this.dateChange.emit(date);
                }
            });
    }

    ngOnDestroy() {
        this.subscribe.unsubscribe();
    }

    ngOnChanges({ date }: SimpleChanges) {
        if (date && date.currentValue && !compare(date.currentValue, date.previousValue)) {
            setTimeout(() => {
                if (date.currentValue instanceof DateTime) {
                    this.bsDatepicker.bsValue = date.currentValue.toJSDate();
                } else {
                    let year = date.currentValue.getFullYear();
                    let month = date.currentValue.getMonth();
                    let day = date.currentValue.getDate();
                    this.bsDatepicker.bsValue = this._dateTimeService.createJSDate(year, month, day);
                }
            }, 0);
        } else {
            setTimeout(() => {
                this.bsDatepicker.bsValue = null;
            }, 0);
        }
    }
}
