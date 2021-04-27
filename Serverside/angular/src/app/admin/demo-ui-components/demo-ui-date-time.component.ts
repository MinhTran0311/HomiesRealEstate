import { Component, ElementRef, Injector, ViewChild } from '@angular/core';
import { DateTimeService } from '@app/shared/common/timing/date-time.service';
import { appModuleAnimation } from '@shared/animations/routerTransition';
import { AppComponentBase } from '@shared/common/app-component-base';
import { DemoUiComponentsServiceProxy } from '@shared/service-proxies/service-proxies';
import { DateTime } from 'luxon';

@Component({
    selector: 'demo-ui-date-time',
    templateUrl: './demo-ui-date-time.component.html',
    animations: [appModuleAnimation()]
})

export class DemoUiDateTimeComponent extends AppComponentBase {

    @ViewChild('SampleDatePicker', {static: true}) sampleDatePicker: ElementRef;
    @ViewChild('SampleDateTimePicker', {static: true}) sampleDateTimePicker: ElementRef;

    sampleDate: DateTime;
    sampleDateRange: DateTime[] = [this._dateTimeService.getStartOfDayMinusDays(7), this._dateTimeService.getStartOfDay()];

    constructor(
        injector: Injector,
        private demoUiComponentsService: DemoUiComponentsServiceProxy,
        private _dateTimeService: DateTimeService
    ) {
        super(injector);
    }

    // default date picker - post
    submitDate(): void {
        this.demoUiComponentsService.sendAndGetDate(this.sampleDate)
            .subscribe(data => {
                this.message.info(data.dateString, this.l('PostedValue'));
            });
    }

    // default date range picker - post
    submitDateRange(): void {
        this.demoUiComponentsService.sendAndGetDateRange(this.sampleDateRange[0], this.sampleDateRange[1])
            .subscribe(data => {
                this.message.info(data.dateString, this.l('PostedValue'));
            });
    }
}
