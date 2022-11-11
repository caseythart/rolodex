(defun create-contact (fname lname email phone comment relationship-type start-date relationship-comment integer)
  (interactive "sFirst Name: \nsLast Name: \nsemail Address (comma separate them if there are multiple): \nsPhone Number: \nsDescribe the person: \nsWhat is your type of relationship with them (family, friend, work): \nsWhen did this relationship start? \nsDescribe the relationship: \nsHow many times a year should you connect with this person? ")
  (insert ":" fname lname " a :Person ;
       :name-first \"" fname "\" ;
       :name-last \"" lname "\" ;
       :emailAddress \"" email "\" ;
       :phoneNumber \"" phone "\" ;
       rdfs:comment \"\"\"" comment"\"\"\" ;
.

:"fname lname"Relationship a ")
  (if (equal relationship-type "work")
      (insert ":WorkRelationship")
    (if (equal relationship-type "family")
	(insert ":FamilialRelationship")
      (insert ":Friendship")))
  (insert ";
       :startTime [:universalDate \""start-date"\"^^xsd:date ;];
       rdfs:comment \"\"\""relationship-comment"\"\"\" ;
       :relationshipParty :CaseyHart, :"fname lname" ;
       :desiredInteractionFrequency [:decimalValue \"" integer "\"^^xsd:integer ; :numeratorUnit :_count ; :denominatorUnit :_year ;] ;
.")
  )


(defun represent-relationship-type (relationship-type )
  (interactive "sRelationship Type (family, friend, work): ")
  (if (equal relationship-type "family")
      (progn (insert ":")
	     (call-interactively 'xah-insert-random-uuid)
	      (delete 1)
	      (insert ":")
	      (end-of-line)
	      (insert " a :Relationship ;"))
    ))

:59C5EA06-7733-4B51-910D-5FF5962F552B
:457034D8-6E04-43C0-A6C7-CB7FB00A5061



(defun xah-insert-random-uuid ()
  "Insert a UUID.
This commands calls “uuidgen” on MacOS, Linux, and calls PowelShell on Microsoft Windows.
URL `http://xahlee.info/emacs/emacs/elisp_generate_uuid.html'
Version 2020-06-04"
  (interactive)
  (cond
   ((string-equal system-type "windows-nt")
    (shell-command "pwsh.exe -Command [guid]::NewGuid().toString()" t))
   ((string-equal system-type "darwin") ; Mac
    (shell-command "uuidgen" t))
   ((string-equal system-type "gnu/linux")
    (shell-command "uuidgen" t))
   (t
    ;; code here by Christopher Wellons, 2011-11-18.
    ;; and editted Hideki Saito further to generate all valid variants for "N" in xxxxxxxx-xxxx-Mxxx-Nxxx-xxxxxxxxxxxx format.
    (let ((myStr (md5 (format "%s%s%s%s%s%s%s%s%s%s"
                              (user-uid)
                              (emacs-pid)
                              (system-name)
                              (user-full-name)
                              (current-time)
                              (emacs-uptime)
                              (garbage-collect)
                              (buffer-string)
                              (random)
                              (recent-keys)))))
      (insert (format "%s-%s-4%s-%s%s-%s"
                      (substring myStr 0 8)
                      (substring myStr 8 12)
                      (substring myStr 13 16)
                      (format "%x" (+ 8 (random 4)))
                      (substring myStr 17 20)
                      (substring myStr 20 32)))))))



