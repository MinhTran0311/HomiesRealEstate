export const MODULE_CONFIG = {
    'OnInit': 'hmrOnInit',
    'OnStatus': 'hmrOnStatus',
    'OnCheck': 'hmrOnCheck',
    'OnDecline': 'hmrOnDecline',
    'OnDestroy': 'hmrOnDestroy',
    'AfterDestroy': 'hmrAfterDestroy'
};
export function hmrModule(MODULE_REF, MODULE, CONFIG = MODULE_CONFIG) {
    if (MODULE['hot']) {
        MODULE['hot']['accept']();
        if (MODULE_REF.instance[MODULE_CONFIG['OnInit']]) {
            if (MODULE['hot']['data']) {
                MODULE_REF.instance[MODULE_CONFIG['OnInit']](MODULE['hot']['data']);
            }
        }
        if (MODULE_REF.instance[MODULE_CONFIG['OnStatus']]) {
            MODULE['hot']['apply'](function hmrOnStatus(status) {
                MODULE_REF.instance[MODULE_CONFIG['OnStatus']](status);
            });
        }
        if (MODULE_REF.instance[MODULE_CONFIG['OnCheck']]) {
            MODULE['hot']['check'](function hmrOnCheck(err, outdatedModules) {
                MODULE_REF.instance[MODULE_CONFIG['OnCheck']](err, outdatedModules);
            });
        }
        if (MODULE_REF.instance[MODULE_CONFIG['OnDecline']]) {
            MODULE['hot']['decline'](function hmrOnDecline(dependencies) {
                MODULE_REF.instance[MODULE_CONFIG['OnDecline']](dependencies);
            });
        }
        MODULE['hot']['dispose'](function hmrOnDestroy(store) {
            if (MODULE_REF.instance[MODULE_CONFIG['OnDestroy']]) {
                MODULE_REF.instance[MODULE_CONFIG['OnDestroy']](store);
            }
            MODULE_REF.destroy();
            if (MODULE_REF.instance[MODULE_CONFIG['AfterDestroy']]) {
                MODULE_REF.instance[MODULE_CONFIG['AfterDestroy']](store);
            }
        });
    }
    return MODULE_REF;
}
//# sourceMappingURL=hmr.js.map