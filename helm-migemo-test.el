;;;; unit test
;; (install-elisp "http://www.emacswiki.org/cgi-bin/wiki/download/el-expectations.el")
;; (install-elisp "http://www.emacswiki.org/cgi-bin/wiki/download/el-mock.el")
(dont-compile
  (when (fboundp 'expectations)
    (expectations
      (desc "match")
      (expect '(("TEST" ("日本語")))
        (let ((helm-use-migemo t))
          (helm-test-candidates
           '(((name . "TEST")
              (candidates "日本語")))
           "nihongo"
           '(helm-compile-source--migemo))))
      (desc "candidates buffer")
      (expect '(("TEST" ("日本語")))
        (let ((helm-use-migemo t))
          (helm-test-candidates
           '(((name . "TEST")
              (init
               . (lambda () (with-current-buffer (helm-candidate-buffer 'global)
                              (insert "日本語\n"))))
              (candidates-in-buffer)))
           "nihongo"
           '(helm-compile-source--candidates-in-buffer
             helm-compile-source--migemo))))
      (desc "migemo attribute")
      (expect '(("TEST" ("日本語")))
        (let ((helm-use-migemo nil))
          (helm-test-candidates
           '(((name . "TEST")
              (candidates "日本語")
              (migemo)))
           "nihongo"
           '(helm-compile-source--migemo))))
      (expect '(("TEST" ("日本語")))
        (let ((helm-use-migemo nil))
          (helm-test-candidates
           '(((name . "TEST")
              (init
               . (lambda () (with-current-buffer (helm-candidate-buffer 'global)
                              (insert "日本語\n"))))
              (candidates-in-buffer)
              (migemo)))
           "nihongo"
           '(helm-compile-source--candidates-in-buffer
             helm-compile-source--migemo))))
      (desc "search-from-end attribute")
      
      (expect '(("FOO" ("日本語入力" "日本語会話")))
        (let ((helm-use-migemo nil))
          (helm-test-candidates '(((name . "FOO")
                                       (init
                                        . (lambda ()
                                            (with-current-buffer (helm-candidate-buffer 'global)
                                              (insert "日本語会話\n日本語入力\n"))))
                                       (candidates-in-buffer)
                                       (migemo)
                                       (search-from-end)))
                                    "nihongo"
                                    '(helm-compile-source--candidates-in-buffer
                                      helm-compile-source--migemo))))
      (expect '(("FOO" ("日本語入力" "日本語会話")))
        (let ((helm-use-migemo t))
          (helm-test-candidates '(((name . "FOO")
                                       (init
                                        . (lambda ()
                                            (with-current-buffer (helm-candidate-buffer 'global)
                                              (insert "日本語会話\n日本語入力\n"))))
                                       (candidates-in-buffer)
                                       (search-from-end)))
                                    "nihongo"
                                    '(helm-compile-source--candidates-in-buffer
                                      helm-compile-source--migemo))))
      (desc "with helm-match-plugin")
      
      (expect '(("FOO" ("日本語入力")))
        (let ((helm-use-migemo nil))
          (helm-test-candidates '(((name . "FOO")
                                       (init
                                        . (lambda ()
                                            (with-current-buffer (helm-candidate-buffer 'global)
                                              (insert "日本語会話\n日本語入力\n"))))
                                       (candidates-in-buffer)
                                       (migemo)))
                                    "nihongo nyuuryoku"
                                    '(helm-compile-source--candidates-in-buffer
                                      helm-compile-source--match-plugin
                                      helm-compile-source--migemo))))
      (expect '(("FOO" ("日本語入力")))
        (let ((helm-use-migemo t))
          (helm-test-candidates '(((name . "FOO")
                                       (init
                                        . (lambda ()
                                            (with-current-buffer (helm-candidate-buffer 'global)
                                              (insert "日本語会話\n日本語入力\n"))))
                                       (candidates-in-buffer)))
                                    "nihongo nyuuryoku"
                                    '(helm-compile-source--candidates-in-buffer
                                      helm-compile-source--match-plugin
                                      helm-compile-source--migemo))))
      (expect '(("FOO" ("日本語入力")))
        (let ((helm-use-migemo nil))
          (helm-test-candidates '(((name . "FOO")
                                       (init
                                        . (lambda ()
                                            (with-current-buffer (helm-candidate-buffer 'global)
                                              (insert "日本語会話\n日本語入力\n"))))
                                       (candidates-in-buffer)
                                       (search-from-end)
                                       (migemo)))
                                    "nihongo nyuuryoku"
                                    '(helm-compile-source--candidates-in-buffer
                                      helm-compile-source--match-plugin
                                      helm-compile-source--migemo))))
      (expect '(("FOO" ("日本語入力")))
        (let ((helm-use-migemo t))
          (helm-test-candidates '(((name . "FOO")
                                       (init
                                        . (lambda ()
                                            (with-current-buffer (helm-candidate-buffer 'global)
                                              (insert "日本語会話\n日本語入力\n"))))
                                       (candidates-in-buffer)
                                       (search-from-end)))
                                    "nihongo nyuuryoku"
                                    '(helm-compile-source--candidates-in-buffer
                                      helm-compile-source--match-plugin
                                      helm-compile-source--migemo))))
      (expect '(("TEST" ("日本語入力")))
        (let ((helm-use-migemo nil))
          (helm-test-candidates
           '(((name . "TEST")
              (migemo)
              (candidates "日本語入力")))
           "nihongo nyuuryoku"
           '(helm-compile-source--match-plugin helm-compile-source--migemo))))
      (expect '(("TEST" ("日本語入力")))
        (let ((helm-use-migemo t))
          (helm-test-candidates
           '(((name . "TEST")
              (candidates "日本語入力")))
           "nihongo nyuuryoku"
           '(helm-compile-source--match-plugin helm-compile-source--migemo))))
      )))
