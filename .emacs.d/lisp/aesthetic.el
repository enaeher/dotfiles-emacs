(set-display-table-slot standard-display-table 'vertical-border ?\u2502)
(set-display-table-slot standard-display-table 'wrap ?↩)

(set-face-inverse-video-p 'vertical-border nil)
(set-face-background 'vertical-border (face-background 'default))
(set-display-table-slot standard-display-table
                        'vertical-border (make-glyph-code ?·))
