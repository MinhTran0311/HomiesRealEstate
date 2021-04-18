import { ModuleWithProviders } from '@angular/core';
import { OAuthModuleConfig } from './oauth-module.config';
import { NullValidationHandler } from './token-validation/null-validation-handler';
import * as ɵngcc0 from '@angular/core';
import * as ɵngcc1 from '@angular/common';
export declare class OAuthModule {
    static forRoot(config?: OAuthModuleConfig, validationHandlerClass?: typeof NullValidationHandler): ModuleWithProviders<OAuthModule>;
    static ɵmod: ɵngcc0.ɵɵNgModuleDefWithMeta<OAuthModule, never, [typeof ɵngcc1.CommonModule], never>;
    static ɵinj: ɵngcc0.ɵɵInjectorDef<OAuthModule>;
}

//# sourceMappingURL=angular-oauth-oidc.module.d.ts.map