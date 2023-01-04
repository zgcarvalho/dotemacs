;; both variables below are saved in a file apart
;; (defvar instatext-nonce "<nonce>")
;; (defvar instatext-cookie "<cookie>")
(load-file "~/.emacs.d/instatext-auth.el")
 
(defun submit-region-to-instatext ()
  "Submit the region to https://instatext.io/api/v1/improve-text using a POST method.
The region is included in the body of the request as a JSON object, with the 'text' field having two children: 'content' and 'language'.
The response is also a JSON object, and the value of the 'text' key is displayed in a new buffer called '*instatext-output*'."
  (interactive)
  (let* ((url "https://instatext.io/api/v1/improve-text")
         (original-text (buffer-substring-no-properties (region-beginning) (region-end)))
         (json-object
          (json-encode
           `(("text" . (("content" . ,original-text)
                        ("language" . "en"))))))
         (url-request-method "POST")
         (url-request-extra-headers
          (list (cons "Content-Type" "application/json")
                (cons "Cookie" instatext-cookie)
                (cons "X-WP-Nonce" instatext-nonce)))
          (url-request-data json-object)
         (response-buffer (url-retrieve-synchronously url)))
    (with-current-buffer response-buffer
      (goto-char url-http-end-of-headers)
      (let* ((response-json (json-read))
             (text (cdr (assoc 'text response-json))))
        (with-current-buffer (get-buffer-create "*instatext-output*")
          (erase-buffer)
          (insert (format "%s" text)))))))

(provide 'submit-region-to-instatext)

