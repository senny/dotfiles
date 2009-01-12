;;; cygwin-mount.el --- Teach EMACS about cygwin styles and mount points.

;; Emacs Lisp Archive Entry
;; Filename: cygwin-mount.el
;; Version: 1.4.5 - 2003-09-02
;; Author: Klaus Berndl <berndl@sdm.de>
;; Maintenance: Klaus Berndl <berndl@sdm.de>
;; Original author: Michael Cook <mcook@cognex.com>
;; Keywords: files, mount, cygwin
;;
;; Additional info:
;; Copyright (C) 1997 Michael Cook <mcook@cognex.com>.
;;               2001 Klaus Berndl <berndl@sdm.de>
;; Additional code by: Keisuke Mori <ksk@ntts.com>
;;                     Drew Moseley (drewmoseley@mindspring.com)
;;                     James Ganong (jeg@bigseal.ucsc.edu)
;;                     Jeff Juliano <juliano@cs.unc.edu>
;;                     Klaus Berndl <berndl@sdm.de>
;;                     Nick Sieger <nsieger@bitstream.net>
;;                     Richard Y. Kim <ryk@dspwiz.com>
;;                     Karel Sprenger <karel.sprenger@compaq.com>
;;
;; cygwin-mount.el is free software
;;
;; This file is *NOT* (yet?) part of GNU Emacs.
;;
;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation; either version 2, or (at your option)
;; any later version.
;;
;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.
;;
;; You should have received a copy of the GNU General Public License
;; along with GNU Emacs; see the file COPYING.  If not, write to the
;; Free Software Foundation, Inc., 59 Temple Place - Suite 330,
;; Boston, MA 02111-1307, USA.

;; ----------------------------------------------------------------------
;;; Commentary

;; This package does all necessary so you can use cygwin-style filenames like
;; "//D/any/path/to/file" or "/cygdrive/D/any/path/to/file" in exactly the
;; same manner as the normal Windows-style filenames like
;; "D:\any\path\to\file" or "D:/any/path/to/file". NOTE: "/cygdrive/" is only
;; an example for the cygdrive-prefix \(see
;; `cygwin-mount-cygdrive-prefix--internal'). cygwin-mount can handle every
;; cygdrive-prefix set by "mount --change-cygdrive-prefix" (e.g. "/" is also a
;; valid cygdrive-prefix).
;; All UNC path-notations will work with cygwin-mount too. For example
;; cygwin-mount handles a path like //HOST/path correct.
;; Furthermore this package enables using all your cygwin-mounts in
;; file-operations. For example you can call all file-operations (e.g.
;; find-file) for a file named "/usr/bin/anyfile" if you have mounted the
;; related Windows-path to /usr/bin. The package also makes sure that ange-ftp
;; will work correct if you are using cygwin-mount.el.

;;; Installation:

;; Put in your .emacs or site-start.el file the following lines:
;;   (require 'cygwin-mount)
;;   (cygwin-mount-activate)

;;; Customization and using

;; + All customization is done in the customize-group `cygwin-mount'.
;;   Do not set the user-options via `setq' but only via customize because
;;   otherwise the package will not work correct!!
;;   Important: Now the cygwin mountpoints are stored in the variable
;;   `cygwin-mount-table--internal'. This variable must not be set by the user
;;   but it is only set by customizing `cygwin-mount-table'!
;; + Activating: cygwin-mount-activate
;; + Deactivating: cygwin-mount-deactivate

;;; Compatibility

;; The cygwin-mount.el package is only tested with NTEmacs >= 20.6.1.
;; It has also been tested with the native port of XEmacs 21.1 but not
;; very intensive!  The package has been tested with Cygwin 1.1.8 and
;; >= 1.3.1.

;;; Availabilty

;; The latest version of cygwin-mount.el can always be found at
;; http://www.emacswiki.org/elisp/index.html

;; ----------------------------------------------------------------------

;;; History:

;; + Version 1.4.5, modified September 2003 by Eric Hanchrow (offby1@blarg.net)
;;   - cygwin-mount-get-mount-regexp now works with cygwin versions > 1.3
;; + Version 1.4.4, modified May 2002 by Klaus Berndl (berndl@sdm.de)
;;   - Fixed a typo which prevents ange-ftp be loaded.
;;   - Added the URL where this library can be found
;; + Version 1.4.3, modified May 2002 by Klaus Berndl (berndl@sdm.de)
;;   - New constant cygwin-mount-version
;;   - Fixing a small bug
;; + Version 1.4.2, modified November 2001 by Klaus Berndl (berndl@sdm.de)
;;   - Checks if the ange-ftp library is installed. If not it skips the
;;     ange-ftp part in this package.
;;   - Also tested slightly with XEmacs native win32-port >= 21.1.
;; + Version 1.4.1, modified June 2001 by Klaus Berndl (berndl@sdm.de)
;;   - Fixed a bug if no cygdrive-prefix for user is set but only for system.
;; + Version 1.4, modified may 2001 by Klaus Berndl (berndl@sdm.de)
;;   - Now every cygdrive-prefix can be handled (see Commentary above).
;;   - All variables and functions have the prefix "cygwin-mount-".
;;
;; + Version 1.3, modified may 2001 by Klaus Berndl (berndl@sdm.de)
;;   - Bugfix in the function `cygwin-mount-substitute-longest-mount-name'.
;;   - much better customization. Now no(!) external processes run only with
;;     loading the package. All the initialization of mount-points etc. is
;;     first done with calling `cygwin-mount-activate'.
;;   - Important: Now the cygwin mountpoints are stored in the new variable
;;     `cygwin-mount-table--internal'. This variable must not be set by the user
;;     but it is only set by customizing `cygwin-mount-table'!
;;
;; + Version 1.2.1, modified may 2001 by Klaus Berndl (berndl@sdm.de):
;;   - renaming the package to cygwin-mount.el
;;   - Better finding of the mount- and uname-program
;;   - now works for different cygwin versions:
;;     * cygwin <= 1.1.8
;;     * cygwin >= 1.3.1
;;     There is a new option `cygwin-mount-parsing-regexp' where these regexps
;;     are defined and where also a custom regexp can be defined.
;;     Thanks for the idea and a first implementation to Charles Curley
;;     (ccurley@trib.com) and Karel Sprenger (karel.sprenger@compaq.com).
;;   - Fixes problem with expand-file-name handling. This behaves differently
;;     from most other primitives that is called via file-name-handler-alist,
;;     because it takes two arguments rather than one. Either one or both
;;     arguments could trigger the invocation of the file-name-handler-alist.
;;     Thanks for the patch to Richard Y. Kim (ryk@dspwiz.com).
;;   - Option to initialize the `cygwin-mount-table' either snychron (default)
;;     or asynchron: `cygwin-mount-build-mount-table-asynch'.
;;     Thanks for the idea and a first implementation to Nick Sieger
;;     (nsieger@bitstream.net).
;;
;; + Version 1.0, modified January 2001 by Klaus Berndl (berndl@sdm.de):
;;   - Added customization
;;   - Added activating and deactivating functions (emacs-packages should not
;;     activating itself only by loading!). Deactivating removes any new
;;     filehandlers and restore the original ange-ftp function.
;;   - Added test, if mount-program exists in PATH and if system-type is
;;     windows-nt.
;;   - Corrects a bug in the longest mount point substitution (network devices
;;     like //Host/Path are now never substituted because a mount point / then
;;     would always be incorrectly substituted. Now all file-operations work
;;     correct with network devices.
;;   - corrects a bug in the /cygdrive/-style regexp.
;;   - Makes the first "real" emacs-package cygwin32-mount.el
;;   All my changes are only removing bugs and adding stuff, so this code
;;   becomes a correct emacs-package. All substantiell working code and ideas
;;   come from the other authors.
;;
;; + Original version 0.1 by Michael Cook <mcook@cognex.com>:
;;   - modified Jun 18 1998 by Keisuke Mori <ksk@ntts.com> to make it work with
;;     ange-ftp and enable mapping a drive letter
;;   - modified Oct 25 1999 by Drew Moseley (drewmoseley@mindspring.com) to
;;     support /cygdrive style drive maps and for better coexistence with
;;     ange-ftp.
;;   - modified Feb 7 2000 by James Ganong (jeg@bigseal.ucsc.edu) to work when
;;     / is mounted in a subdirectory instead of top level of a drive, and to
;;     check longest directory names first, to a / mount does not shadow.
;;   - modified Mar 23 2000 by Jeff Juliano <juliano@cs.unc.edu> to make a
;;     user-callable function that performs the mapping. I use this in my
;;     .emacs file to find my non-version-specific site-lisp directory since
;;     NTemacs doesn't have one in its search path.
;;   - modified July 2000 by Jeff Juliano <juliano@cs.unc.edu>: ps-print to
;;     //machine/printer-name was broken. cygwin-mount would intercept and try
;;     to convert the name to a local path, even though one doesn't exist.
;;     Also, don't do mount table lookup as early as used to. warning: this
;;     isn't extensively tested, and may not be correct.

;;; Code:

(require 'cl)
(require 'executable)

(defconst cygwin-mount-version "1.4.3")

(defgroup cygwin-mount nil
  "Proper handling of cygwin mounts and filenames."
  :prefix "cygwin-"
  :group 'files)

;; some constants

(defconst cygwin-mount<=1.1.8-mount-regexp
  "^\\([a-z]:[^ \t\n]*\\) +\\([^ \t\n]+\\)")
(defconst cygwin-mount>=1.3.1-mount-regexp
  "^\\([a-z]:.*\\)[ \t]+on[ \t]+\\(.+\\) type \\(system\\|user\\)")
(defconst cygwin-mount-program "mount.exe")
(defconst cygwin-mount-uname-program "uname.exe")
(defconst cygwin-mount-buffername " *mount*")

;; internal variables. These variables are only set by calling
;; `cygwin-mount-activate' or by customizing `cygwin-mount-table' or
;; `cygwin-mount-parsing-regexp'.
(defvar cygwin-mount-parsing-regexp--internal ""
  "Do not touch. Customize `cygwin-mount-parsing-regexp' instead!")

(defvar cygwin-mount-table--internal nil
  "Do not set this variable directly but customize `cygwin-mount-table'!")

(defvar cygwin-mount-cygdrive-prefix--internal ""
  "Prefix for the \"/cygdrive/X/\" style of cygwin.
A cygwin-user can change the \"/cygdrive\" to whatever he wants to access
files at MS-DOS drives. For example many people seem to like to have the
drives accessible as a directory so that c: == /c, which means the
cygdrive-prefix is \"/\" instead of \"/cygdrive\". This prefix must end
with a '/'!  Do not set this variable because the value of this variable is
determined at activation-time of cygwin-mount \(see
`cygwin-mount-activate')")

;; user options

(defcustom cygwin-mount-cygwin-bin-directory nil
  "*The directory where the cygwin binaries reside.
If nil then the cygwin-binary-directory must be into the PATH."
  :group 'cygwin-mount
  :type '(radio	(const :tag "Cygwin is into PATH" :value nil)
		(directory :tag "Cygwin-Binary-Dir" :value "")))

(defcustom cygwin-mount-parsing-regexp t
  "*Rexexp used to parse the output of the mount program.
Available values are:
- A regexp: The regexp must define two subexpressions where the first one must
  build the car of an element in the syntax of `cygwin-mount-table' and the
  second one must build the cdr. There are two predefined regexps, one for
  cygwin <= 1.1.8 and one for cygwin >= 1.3.1. But there is also the
  possibility to define a custom regexp.
- t \(default): Checks which cygwin version is running and sets the correct
  regexp automatically. Currently cygwin versions <=1.1.8 and >=1.3.1 are
  supported."
  :group 'cygwin-mount
  :set (function (lambda (symbol value)
                   (set symbol value)
                   (setq cygwin-mount-parsing-regexp--internal
                         (if (equal value t)
                             (cygwin-mount-get-mount-regexp)
                           value))))
  :initialize 'custom-initialize-default
  :type `(radio (const :tag "Automatic" :value t)
                (const :tag "Cygwin <= 1.1.8"
		       :value ,cygwin-mount<=1.1.8-mount-regexp)
		(const :tag "Cygwin >= 1.3.1"
		       :value ,cygwin-mount>=1.3.1-mount-regexp)
		(regexp :tag "Custom" :value "")))


(defcustom cygwin-mount-build-mount-table-asynch nil
  "*When non-il `cygwin-mount-table' is build at load-time.
If you change the value via customize you must deactivate and activate the
package again to take effect."
  :group 'cygwin-mount
  :type 'boolean)

(defcustom cygwin-mount-table t
  "*Alist of custom cygwin mount points or t.
If t if all the current mount-points returned by the cygwin mount-program
should be used. If set to nil then there are no mount-points. An element of
the alist has the form \(<mounted windows-device> . <cygwin-directory>),
e.g.  \(\"D:\\\\programs\\\\cygwin\\\\bin\" . \"/usr/bin/\") or
\(\"D:/programs/cygwin\" . \"/\")."
  :group 'cygwin-mount
  :set (function (lambda (symbol value)
                   (set symbol value)
                   (if (equal value t)
                       (cygwin-mount-build-table-internal)
                     (setq cygwin-mount-table--internal value))))
  :initialize 'custom-initialize-default
  :type '(radio	(const :tag "Automatic"
                       :value t)
                (repeat :tag "Custom mounts"
                        (cons (directory :tag "Mounted device")
                              (string :tag "Cygwin directory")))))

;; copied from executable.el because this library is not included in all
;; Emacsen by default.
(defvar cygwin-mount-executable-binary-suffixes
  (if (memq system-type '(ms-dos windows-nt))
      '(".exe" ".com" ".bat" ".cmd" ".btm" "")
    '("")))
(defun cygwin-mount-executable-find (command)
  "Search for COMMAND in `exec-path' and return the absolute file name.
Return nil if COMMAND is not found anywhere in `exec-path'."
  (let ((list exec-path)
	file)
    (while list
      (setq list
	    (if (and (setq file (expand-file-name command (car list)))
		     (let ((suffixes cygwin-mount-executable-binary-suffixes)
			   candidate)
		       (while suffixes
			 (setq candidate (concat file (car suffixes)))
			 (if (and (file-executable-p candidate)
				  (not (file-directory-p candidate)))
			     (setq suffixes nil)
			   (setq suffixes (cdr suffixes))
			   (setq candidate nil)))
		       (setq file candidate)))
		nil
	      (setq file nil)
	      (cdr list))))
    file))

;; functions

(defun cygwin-mount-get-full-progname (program)
  "Return the full path of PROGRAM if possible or nil."
  (let ((fullname
         (if (and cygwin-mount-cygwin-bin-directory
                  (stringp cygwin-mount-cygwin-bin-directory)
                  (file-directory-p cygwin-mount-cygwin-bin-directory))
             (concat (file-name-as-directory cygwin-mount-cygwin-bin-directory)
                     program)
           (expand-file-name (or (cygwin-mount-executable-find program)
                                 program)))))
    (if (file-executable-p fullname)
        fullname
      nil)))

(defvar cygwin-mount-cygwin-version nil
  "Version string of the cygwin-version currently used.
Only set by `cygwin-mount-get-cygwin-version'.")
(defun cygwin-mount-get-cygwin-version ()
  "Return cygwin version string by calling \"uname -r\"."
  (if (stringp cygwin-mount-cygwin-version)
      cygwin-mount-cygwin-version
    (let ((buf (get-buffer-create " *uname*"))
          (fullname (cygwin-mount-get-full-progname cygwin-mount-uname-program)))
      (if (null fullname)
          (error "Cannot find the program '%s', please check 'cygwin-mount-cygwin-bin-directory'!" cygwin-mount-uname-program)
        (save-excursion
          (set-buffer buf)
          (erase-buffer)
          (call-process fullname nil buf nil "-r")
          (goto-char (point-min))
          (prog1
              (if (search-forward-regexp "^\\([^(]+\\)" (point-max) t)
                  (setq cygwin-mount-cygwin-version (match-string 1)))
            (kill-buffer buf)))))))

(defun cygwin-mount-get-mount-regexp ()
  "Return correct regexp for parsing the mount-output.
Currently there is only a distiction between cygwin versions
<= and >= 1.3.1."
  (let ((version (cygwin-mount-get-cygwin-version)))
    (if (not (string< (cygwin-mount-get-cygwin-version) "1.3.1"))
      cygwin-mount>=1.3.1-mount-regexp
    cygwin-mount<=1.1.8-mount-regexp)))

(defun cygwin-mount-get-cygdrive-prefix ()
  "Return prefix used for the \"/cygdrive/X/\" style of cygwin.
This is done by calling \"mount --show-cygdrive-prefixes\".
The result is either \"/\" or \"/<string>/\"."
  (let ((buf (get-buffer-create " *cygdrive*"))
        (fullname (cygwin-mount-get-full-progname cygwin-mount-program))
	(arg (if (string-match "^1\\.3" (cygwin-mount-get-cygwin-version))
		 "--show-cygdrive-prefix" "--show-cygdrive-prefixes")))
    (if (null fullname)
        (error "Cannot find the program '%s', please check 'cygwin-mount-cygwin-bin-directory'!" cygwin-mount-program)
      (save-excursion
        (set-buffer buf)
        (erase-buffer)
        (call-process fullname nil buf nil arg)
        (goto-char (point-min))
        (prog1
            (let ((regexp-prefix "\\(/[^ \t]*\\)[ \t]+")
                  cygdrive-prefix)
              ;; we search first for the user prefix and if there isn't any we
              ;; search for the system prefix.
              (if (or (search-forward-regexp (concat regexp-prefix "user") nil t)
                      (search-forward-regexp (concat regexp-prefix "system") nil t))
                  (progn
                    (setq cygdrive-prefix (match-string 1))
                    (if (string= cygdrive-prefix "/")
                        cygdrive-prefix
                      (concat cygdrive-prefix "/")))
              "/cygdrive/"))
          (kill-buffer buf))))))

(defun cygwin-mount-parse-mount ()
  "Parse buffer `cygwin-mount-buffername' and return alist of mount-points.
For the format of this alist see `cygwin-mount-table'.
Precondition of this function is current buffer must be the buffer named
`cygwin-mount-buffername'."
  (if (equal (current-buffer) (get-buffer cygwin-mount-buffername))
      (let ((case-fold-search t)
            mounts)
        ;; first pass tags each line with the length of the directory
        (goto-char (point-min))
        (while (search-forward-regexp cygwin-mount-parsing-regexp--internal nil t)
          (let ((direct (file-name-as-directory (buffer-substring
                                                 (match-beginning 2)
                                                 (match-end 2)))))
            (end-of-line) (insert ( format "\t%d" (length direct )))))

        ;; now sort the lines numerically
        (sort-numeric-fields -1 (point-min) (point-max))

        ;; 2nd pass builds the mount list
        (goto-char (point-min))
        (while (search-forward-regexp cygwin-mount-parsing-regexp--internal nil t)
          (let ((device (file-name-as-directory (buffer-substring
                                                 (match-beginning 1)
                                                 (match-end 1))))
                (direct (file-name-as-directory (buffer-substring
                                                 (match-beginning 2)
                                                 (match-end 2)))))
            (setq mounts (cons (cons device direct) mounts))))
        mounts)))

(defun cygwin-mount-sentinel (proc msg)
  "Process sentinel for PROC with MSG."
  (if (or (eq (process-status proc) 'exit)
	  (eq (process-status proc) 'signal))
      (let ((buf (get-buffer-create cygwin-mount-buffername)))
	(save-excursion
	  (set-buffer buf)
          (setq cygwin-mount-table--internal (cygwin-mount-parse-mount)))
	(kill-buffer buf)
	(message "Build of mount table completed"))))

(defun cygwin-mount-build-table-internal ()
  "Determine cygwin mount points.
This function sets `cygwin-mount-table--internal'
either synchronously or asynchronously \(see
`cygwin-mount-build-mount-table-asynch'). If asynchronously then the set is
really done by `cygwin-mount-sentinel'."
  (let ((fullname (cygwin-mount-get-full-progname cygwin-mount-program)))
    (if (null fullname)
        (error "Cannot find the program '%s', please check 'cygwin-mount-cygwin-bin-directory'!" cygwin-mount-program)
      (if cygwin-mount-build-mount-table-asynch
          ;; asynchron building
          (let ((proc (start-process "mount" cygwin-mount-buffername fullname)))
            (set-process-sentinel proc 'cygwin-mount-sentinel)
            (process-kill-without-query proc))
        ;; synchron building
        (let ((buf (get-buffer-create cygwin-mount-buffername)))
          (save-excursion
            (set-buffer buf)
            (erase-buffer)
            (call-process fullname nil buf)
            (prog1
                (setq cygwin-mount-table--internal (cygwin-mount-parse-mount))
              (kill-buffer buf))))))))

(defun cygwin-mount-name-hook-function (operation &rest args)
  "Run OPERATION with ARGS."
  (let ((fn (get operation 'cygwin-mount-name)))
    (if fn (apply fn operation args)
      (cygwin-mount-run-real-handler operation args))))

(defun cygwin-mount-map-drive-hook-function (operation &rest args)
  "Run OPERATION with ARGS."
  (let ((fn (get operation 'cygwin-mount-map-drive)))
    (if fn (apply fn operation args)
      (cygwin-mount-run-real-handler operation args))))

(defun cygwin-mount-run-real-handler (operation args)
  "Run OPERATION with ARGS."
  (let ((inhibit-file-name-handlers
         (cons 'cygwin-mount-name-hook-function
               (cons 'cygwin-mount-map-drive-hook-function
                     (and (eq inhibit-file-name-operation operation)
                          inhibit-file-name-handlers))))
        (inhibit-file-name-operation operation))
    (apply operation args)))


(defun cygwin-mount-name-expand (operation name &rest args)
  "Run OPERATION NAME with ARGS."
  (cygwin-mount-run-real-handler
   operation
   (cons (cygwin-mount-substitute-longest-mount-name name) args)))

(defun cygwin-mount-substitute-longest-mount-name (name)
  "Substitute NAME with mount device or return NAME."
  (save-match-data
    (if (or (string-match "^//.+" name) (string-match "/\\[.+\\]" name))
        ;; Added by Klaus: if name beginns with "//" then it can never contain
        ;; a cygwin mount point! Therefore we must not check for contained
        ;; mount points because if / is mounted then this will always match
        ;; and we get an incorrect substitution for network devices like
        ;; //Host/path
        name
      (let ((mounts cygwin-mount-table--internal)
            (len (length (file-name-as-directory name)))
            match)
        (while mounts
          (let ((mount (file-name-as-directory (cdar mounts))))
            (and (>= len (length mount))
                 (string= mount
                          (file-name-as-directory
                           (substring (file-name-as-directory name)
                                      0 (length mount))))
                 (or (null match)
                     (> (length (cdar mounts)) (length (cdr match))))
                 (setq match (car mounts))))
          (setq mounts (cdr mounts)))
        (if match
            (concat (file-name-as-directory (car match))
                    (if (>= (length (file-name-as-directory (cdr match))) len)
                        ""
                      (substring name (length (file-name-as-directory (cdr match))))))
          name)))))

;; Added by Klaus
(defconst cygwin-mount-cygwin-style1-regexp "^/[^:@]*$\\|^/|/[^/:]+\\(\\'\\|/\\)")
(defconst cygwin-mount-cygwin-style2-regexp "^//[A-Za-z]/")
;; will be set by `cygwin-mount-activate'.
(defvar cygwin-mount-cygwin-style3-regexp nil)

;; We cannot assume thate NAME matched cygwin-mount-cygwin-style1-regexp,
;; cygwin-mount-cygwin-style2-regexp nor cygwin-mount-cygwin-style3-regexp,
;; because this function could be called with either argument to
;; `expand-file-name', but only one argument to `expand-file-name' may
;; have matched a regexp.
;; For example, `(expand-file-name ".." "/cygdrive/c/")' will trigger
;; `(cygwin-mount-convert-file-name "..")' and
;; `(cygwin-mount-convert-file-name "/cygdrive/c/")' to be called.
(defun cygwin-mount-convert-file-name ( name )
  "Convert file NAME, to cygwin format.
`//x/' to `x:/' and `/cygdrive/x/' to `x:/'.
NOTE: \"/cygdrive/\" is only an example for the cygdrive-prefix \(see
`cygwin-mount-cygdrive-prefix--internal')."
  (let ((cygdrive-prefix-len (length cygwin-mount-cygdrive-prefix--internal)))
    (save-match-data
      (cond ((string-match "^//[a-zA-Z]/" name)
             (concat (substring name 2 3) ":" (substring name 3)))
            ((string-match cygwin-mount-cygwin-style3-regexp name)
             (concat (substring name cygdrive-prefix-len
                                (1+ cygdrive-prefix-len))
                     ":" (substring name (1+ cygdrive-prefix-len) nil)))
            (t name)))))

(defun cygwin-mount-map-drive (operation name &rest args)
  "Run OPERATION on cygwin NAME with ARGS.
Map cygwin name to the dos-style \"[A-Za-z]:/\" and call
OPERATION with the mapped filename\(s). NAME must have the format looks like
\"^//[A-Za-z]/\" or \"/cygdrive/[A-Za-z]/\" here. Note that at least the first
element of ARGS could be a filename too \(then it must have the same syntax
like NAME!) which must be converted \(e.g. `expand-file-name' can be called
with two filenames).
NOTE: \"/cygdrive/\" is only an example for the cygdrive-prefix \(see
`cygwin-mount-cygdrive-prefix--internal')."
  (cygwin-mount-run-real-handler
   operation
   (cons (cygwin-mount-convert-file-name name)
	 (if (stringp (car args))
 	     (cons (cygwin-mount-convert-file-name (car args))
		   (cdr args))
	   args))))

;;; ange-ftp
(if (locate-library "ange-ftp")
    (require 'ange-ftp))

;;; save the original function definition of ange-ftp-run-real-handler
(defconst cygwin-mount-original-ange-ftp-handler
  (if (featurep 'ange-ftp) 
      (symbol-function 'ange-ftp-run-real-handler)
    nil))

;;; This version of ange-ftp-run-real-handler also inhibits the
;;; cygwin file name expansion when we are doing ange-ftp expansion.
;;;
;;; This is a real hack.  If the real definition of this function
;;; changes, we have to modify this function
(defun cygwin-mount-ange-ftp-run-real-handler (operation args)
  "Run OPERATION with ARGS."
  (let ((inhibit-file-name-handlers
         (cons 'ange-ftp-hook-function
               (cons 'ange-ftp-completion-hook-function
                     (cons 'cygwin-mount-name-hook-function
                           (cons 'cygwin-mount-map-drive-hook-function
                                 (and (eq inhibit-file-name-operation
                                          operation)
                                      inhibit-file-name-handlers))))))
        (inhibit-file-name-operation operation))
    (apply operation args)))

;; Added by Klaus
(defvar cygwin-mount-activated nil)
(defun cygwin-mount-activate ()
  "Activate cygwin-mount- and cygwin-style-handling."
  (interactive)
  (if (not (eq system-type 'windows-nt))
      (message "cygwin-mount is only available for Emacs for NT!")

    (unless cygwin-mount-activated
      ;; initialize the internal variables
      (setq cygwin-mount-parsing-regexp--internal
            (if (equal cygwin-mount-parsing-regexp t)
                (cygwin-mount-get-mount-regexp)
              cygwin-mount-parsing-regexp))
      (if (equal cygwin-mount-table t)
          (cygwin-mount-build-table-internal)
        (setq cygwin-mount-table--internal cygwin-mount-table))
      (setq cygwin-mount-cygdrive-prefix--internal
            (cygwin-mount-get-cygdrive-prefix))
      (setq cygwin-mount-cygwin-style3-regexp
            (concat "^" cygwin-mount-cygdrive-prefix--internal "[A-Za-z]/"))

      ;; add the cygwin-filehandlers
      (or (assoc cygwin-mount-cygwin-style1-regexp file-name-handler-alist)
          (setq file-name-handler-alist
                (cons `(,cygwin-mount-cygwin-style1-regexp
                        . cygwin-mount-name-hook-function)
                      file-name-handler-alist)))

      (or (assoc cygwin-mount-cygwin-style2-regexp file-name-handler-alist)
          (setq file-name-handler-alist
                (cons `(,cygwin-mount-cygwin-style2-regexp
                        . cygwin-mount-map-drive-hook-function)
                      file-name-handler-alist)))
      (or (assoc cygwin-mount-cygwin-style3-regexp file-name-handler-alist)
          (setq file-name-handler-alist
                (cons `(,cygwin-mount-cygwin-style3-regexp
                        . cygwin-mount-map-drive-hook-function)
                      file-name-handler-alist)))

      ;; add cygwin-properties
      (put 'substitute-in-file-name 'cygwin-mount-name
           'cygwin-mount-name-expand)
      (put 'expand-file-name 'cygwin-mount-name 'cygwin-mount-name-expand)
      (put 'substitute-in-file-name
           'cygwin-mount-map-drive 'cygwin-mount-map-drive)
      (put 'expand-file-name 'cygwin-mount-map-drive
           'cygwin-mount-map-drive)
      ;; rebind ange-ftp-run-real-handler to our version
      (if (featurep 'ange-ftp)
	  (fset 'ange-ftp-run-real-handler 'cygwin-mount-ange-ftp-run-real-handler))

      (setq cygwin-mount-activated t))))

;; Added by Klaus
(defun cygwin-mount-deactivate ()
  "Deactivate cygwin-mount- and cygwin-style-handling."
  (interactive)
  (if (not (eq system-type 'windows-nt))
      (message "cygwin-mount is only available for (X)Emacs for NT!")
    (unless (not cygwin-mount-activated)
      ;; reset the internal variables
      (setq cygwin-mount-table--internal nil)
      (setq cygwin-mount-parsing-regexp--internal "")
      (setq cygwin-mount-cygdrive-prefix--internal "")

      ;; remove the cygwin-filehandlers
      (setq file-name-handler-alist
            (delete (assoc cygwin-mount-cygwin-style1-regexp file-name-handler-alist)
                    file-name-handler-alist))
      (setq file-name-handler-alist
            (delete (assoc cygwin-mount-cygwin-style2-regexp file-name-handler-alist)
                    file-name-handler-alist))
      (setq file-name-handler-alist
            (delete (assoc cygwin-mount-cygwin-style3-regexp file-name-handler-alist)
                    file-name-handler-alist))
      ;; remove the cygwin properties
      (put 'substitute-in-file-name 'cygwin-mount-name nil)
      (put 'expand-file-name 'cygwin-mount-name nil)
      (put 'substitute-in-file-name 'cygwin-mount-map-drive nil)
      (put 'expand-file-name 'cygwin-mount-map-drive nil)
      ;; rebind ange-ftp-run-real-handler to it´s original definition.
      (if (featurep 'ange-ftp)
	  (fset 'ange-ftp-run-real-handler cygwin-mount-original-ange-ftp-handler))
      (setq cygwin-mount-activated nil))))

(provide 'cygwin-mount)

;;; cygwin-mount.el ends here
