{ den, lib, ... }:
{
  den.aspects.vscode._.settings = {
    # Bundles all settings components when the complete 'settings' sub-aspect is used
    includes = lib.attrValues den.aspects.vscode._.settings._;
  };
}
