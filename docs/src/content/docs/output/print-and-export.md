---
title: Print and export
description: Print a document, save it as a PDF, or export a standalone HTML file.
sidebar: { order: 1 }
---

Three commands in the **File** menu turn a document into something you can
hand to someone else. All three render with the same engine as the preview,
so diagrams, tables, and callouts come out as you saw them.

## Print

**File ▸ Print…** (<kbd>⌘P</kbd>) opens the system print dialog with the
rendered document. On macOS that dialog's **Save as PDF** is another way to
get a PDF.

On Windows and Linux the document first opens in a print window with
**Print…** and **Close** buttons; <kbd>Esc</kbd> closes it.

## Export as PDF

**File ▸ Export as PDF…** asks where to save and writes the PDF directly,
with no dialog in between. The status bar shows *Exporting PDF…* and then
the file name.

## Export as HTML

**File ▸ Export as HTML…** writes a single HTML file with the styles
inlined, so it can be sent or published as it is. Image paths are made
relative to the file.

## How the output looks

Printed pages, PDFs, and HTML exports always use your **light** theme,
whichever appearance the app is in. If you want a particular look on paper,
pick it as the light theme in **Settings ▸ Appearance**.

On paper and in PDFs, headings and links to other places in the same
document are printed in the body text colour rather than the theme's
accent, so a hand-written table of contents or a set of footnotes does not
come out blue. The HTML export keeps the theme's colours.

**Settings ▸ Preview ▸ Print & PDF** adds extra left and right margin and a
top-of-page offset, both 8 mm by default.
