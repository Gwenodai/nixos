{ den, lib, ... }:
{
  den.aspects.vscode._.languages = {
    # Bundles all languages components when the complete 'languages' sub-aspect is used
    includes = lib.attrValues den.aspects.vscode._.languages._;
  };
}
