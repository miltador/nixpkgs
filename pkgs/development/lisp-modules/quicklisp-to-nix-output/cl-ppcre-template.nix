args @ { fetchurl, ... }:
rec {
  baseName = ''cl-ppcre-template'';
  version = ''cl-unification-20170124-git'';

  description = ''A system used to conditionally load the CL-PPCRE Template.

This system is not required and it is handled only if CL-PPCRE is
available.  If it is, then the library provides the
REGULAR-EXPRESSION-TEMPLATE.'';

  deps = [ args."cl-ppcre" ];

  src = fetchurl {
    url = ''http://beta.quicklisp.org/archive/cl-unification/2017-01-24/cl-unification-20170124-git.tgz'';
    sha256 = ''0gwk40y5byg6q0hhd41rqf8g8i1my0h4lshc63xfnh3mfgcc8bx9'';
  };

  overrides = x: {
    postInstall = ''
      find "$out/lib/common-lisp/" -name '*.asd' | grep -iv '/cl-ppcre-template[.]asd${"$"}' |
        while read f; do
          CL_SOURCE_REGISTRY= \
          NIX_LISP_PRELAUNCH_HOOK="nix_lisp_run_single_form '(asdf:load-system :$(basename "$f" .asd))'" \
            "$out"/bin/*-lisp-launcher.sh ||
          mv "$f"{,.sibling}; done || true
    '';
  };
}
/* (SYSTEM cl-ppcre-template DESCRIPTION A system used to conditionally load the CL-PPCRE Template.

This system is not required and it is handled only if CL-PPCRE is
available.  If it is, then the library provides the
REGULAR-EXPRESSION-TEMPLATE.
    SHA256 0gwk40y5byg6q0hhd41rqf8g8i1my0h4lshc63xfnh3mfgcc8bx9 URL http://beta.quicklisp.org/archive/cl-unification/2017-01-24/cl-unification-20170124-git.tgz
    MD5 dd277adaf3a0ee41fd0731f78519b1b1 NAME cl-ppcre-template TESTNAME NIL FILENAME cl-ppcre-template DEPS ((NAME cl-ppcre)) DEPENDENCIES (cl-ppcre) VERSION
    cl-unification-20170124-git SIBLINGS (cl-unification-lib cl-unification-test cl-unification)) */
