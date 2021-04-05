import { Component, Injector, ViewChild } from '@angular/core';
import { AppConsts } from '@shared/AppConsts';
import { AppComponentBase } from '@shared/common/app-component-base';
import { ProfileServiceProxy, UserLoginAttemptDto, UserLoginServiceProxy } from '@shared/service-proxies/service-proxies';
import { DateTime } from 'luxon';
import { ModalDirective } from 'ngx-bootstrap/modal';
import { DateTimeService } from '../common/timing/date-time.service';

@Component({
    selector: 'loginAttemptsModal',
    templateUrl: './login-attempts-modal.component.html'
})
export class LoginAttemptsModalComponent extends AppComponentBase {

    @ViewChild('loginAttemptsModal', {static: true}) modal: ModalDirective;

    userLoginAttempts: UserLoginAttemptDto[];
    profilePicture = AppConsts.appBaseUrl + '/assets/common/images/default-profile-picture.png';
    defaultProfilePicture = AppConsts.appBaseUrl + '/assets/common/images/default-profile-picture.png';

    constructor(
        injector: Injector,
        private _userLoginService: UserLoginServiceProxy,
        private _profileService: ProfileServiceProxy,
        private _dateTimeService: DateTimeService
    ) {
        super(injector);
    }

    show(): void {
        this._userLoginService.getRecentUserLoginAttempts().subscribe(result => {
            this.userLoginAttempts = result.items;
            this._profileService.getProfilePicture().subscribe(result => {
                if (result && result.profilePicture) {
                    this.profilePicture = 'data:image/jpeg;base64,' + result.profilePicture;
                }
                this.modal.show();
            });
        });
    }

    close(): void {
        this.modal.hide();
    }

    setProfilePictureClass(userLoginAttemptResult: string): any {
        const classes = {
            label: true,
            'label-success': userLoginAttemptResult === 'Success',
            'label-danger': userLoginAttemptResult !== 'Success'
        };

        return classes;
    }

    getLoginAttemptTime(userLoginAttempt: UserLoginAttemptDto): string {
        return this._dateTimeService.fromNow(userLoginAttempt.creationTime) + ' (' + this._dateTimeService.formatDate(userLoginAttempt.creationTime, 'yyyy-LL-dd hh:mm:ss') + ')';
    }
}
