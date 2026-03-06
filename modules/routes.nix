# This aspect, when installed in a `parametric.atLeast`
# will just forward the same context.
# The `mutual` helper returns an static configuration which
# is ignored by parametric aspects, thus allowing
# non-existing aspects to be just ignored.
{
  den,
  ...
}: {
  # Usage: `den.default.includes [ den.aspects.routes ]`
  den.aspects.routes = let
    inherit (den.lib) parametric;
    # eg, `<user>._.<host>` and `<host>._.<user>`
    mutual = from: to: den.aspects.${from.aspect}._.${to.aspect} or { };
    routes = { host, user, ... }@ctx:
      parametric.fixedTo ctx {
        includes = [
          ( mutual user host )
          ( mutual host user )
        ];
      };
  in routes;
}
