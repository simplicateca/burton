/* eslint-disable no-var,object-shorthand,func-names,no-undef,no-param-reassign */
(function ($R) {
  $R.add('plugin', 'baukasten', {
    init: function (app) {
      this.app = app;
      this.toolbar = app.toolbar;
      this.selection = app.selection;

      this.styles = {
        marked: {
          title: 'Marked',
          api: 'module.inline.format',
          args: {
            tag: 'mark',
            class: 'rd-mark',
          },
        },
        markedAlt: {
          title: 'Marked (Alt)',
          api: 'module.inline.format',
          args: {
            tag: 'mark',
            class: 'rd-mark-alt',
          },
        },        
        superscript: {
          title: 'Superscript ⁰¹²',
          api: 'module.inline.format',
          args: {
            tag: 'sup',
            class: 'rd-sup',
          },
        },
        subscript: {
          title: 'Subscript ₙₒ₁',
          api: 'module.inline.format',
          args: {
            tag: 'sub',
            class: 'rd-sub',
          },
        },
        deleted: {
          title: 'Deleted',
          api: 'module.inline.format',
          args: {
            tag: 'del',
            class: 'rd-del',
          },
        },
        clearStyles: {
          title: 'Clear Styles',
          api: 'module.inline.clearformat',
        },
      };
    },

    start: function () {
      var dropdownData = {};

      for (var key in this.styles) {
        var style = this.styles[key];
        dropdownData[key] = {
          title: style.title,
          args: style.args,
          api: style.api,
        };
      }

      dropdownData['line'] = {
        title: 'Horizontal Line',
        api: 'module.line.insert',
      }

      var btnData = {
        title: 'Styling',
        icon: '<svg version="1.0" xmlns="http://www.w3.org/2000/svg" width="16" height="16" viewBox="0 0 512 512"><path fill="#777879" d="M374.6 3.5c-18.9 6.8-22.6 33.2-6.2 44.2 6.7 4.6 10.3 5.3 25.9 5.3H408v406h-13.6c-15.8 0-20.2.9-26.5 5.5-9.7 7-12.8 20.5-7.1 31.6 3.1 6.1 9.2 11.3 15.2 12.9 2.6.7 22.9 1 59.7.8 52.5-.3 56-.4 59.6-2.2 5.4-2.7 9.6-7.2 12.5-13.5 5.4-11.8-.2-26.1-12.8-32.7-2.9-1.5-6.5-1.9-19.7-2.2l-16.3-.4V53.2l16.3-.4c18-.4 21.1-1.3 27.3-8 5.2-5.5 6.8-9.5 6.9-17.3 0-10.6-4.8-18.4-14.1-23.1-3.7-1.8-6.8-1.9-60.4-2.1-46.2-.2-57.2 0-60.4 1.2zM18.6 54.5C13 56.5 7.9 61 5 66.6l-2.5 4.8L2.2 254c-.2 137.6 0 183.6.9 186.8 1.7 6 6 11.6 11.6 14.9l4.8 2.8 132.9.3c147.7.3 138.7.6 146-6.4 13.1-12.7 10-33.5-6.1-41.5l-4.8-2.4-117.2-.3L53 408V104l117.3-.2 117.2-.3 5.1-2.7c16-8.5 18.9-28.5 5.8-41.2-7.2-7 1.7-6.6-144.3-6.6-109.3.1-132.3.3-135.5 1.5z"/><path fill="#222324" d="M196.8 130.5c-5.1 1.9-10.3 6-12.7 9.9-1.1 1.7-19.5 50-41 107.4-34.9 93-39.1 104.8-39.1 110 0 16.6 15.7 28.6 31.7 24.3 5.2-1.4 12.1-6.5 14.7-11 1-1.8 4.9-11.2 8.5-20.9l6.7-17.7 39.5-.3 39.6-.2 7.4 19.7c8.1 21.6 11.1 26.6 17.9 30.1 10.7 5.6 27.8-1.1 34.3-13.3 1.5-2.8 2.1-5.9 2.2-10.5 0-6.2-2-11.9-39.4-111.2-42.5-113.2-41.2-110.3-50.4-115-5.2-2.6-14.9-3.3-19.9-1.3zm18.6 123.6c5.3 14 9.6 25.9 9.6 26.2 0 .4-9 .7-20.1.7-18.8 0-20.1-.1-19.4-1.8.4-.9 4.7-12.5 9.7-25.7 9-24.1 9.7-25.9 10.3-25.3.2.2 4.6 11.8 9.9 25.9z"/></svg>'
      };

      // create the button
      var $button = this.toolbar.addButtonAfter('italic', 'baukasten', btnData);

      // set dropdown
      $button.setDropdown(dropdownData);
    },

    togglePrimary: function () {
      this.toggleLinkStyles('c-link  c-link--primary', 'a');
    },

    toggleSecondary: function () {
      this.toggleLinkStyles('c-link  c-link--secondary', 'a');
    },

    toggleOutlined: function () {
      this.toggleLinkStyles('c-link  c-link--outlined', 'a');
    },

    toogleHeadingsh2: function () {
      this.toggleHeadingStyles('c-headline  c-headline--h2', this.headings);
    },

    toogleHeadingsh3: function () {
      this.toggleHeadingStyles('c-headline  c-headline--h3', this.headings);
    },

    toogleHeadingsh4: function () {
      this.toggleHeadingStyles('c-headline  c-headline--h4', this.headings);
    },

    toogleHeadingsh5: function () {
      this.toggleHeadingStyles('c-headline  c-headline--h5', this.headings);
    },

    toogleHeadingsh6: function () {
      this.toggleHeadingStyles('c-headline  c-headline--h6', this.headings);
    },

    // Heading Styles
    toggleHeadingStyles: function (classToToggle, els) {
      var selectedHeadings = this.selection.getBlocks({
        first: true,
        tags: els,
      });

      selectedHeadings.forEach(function (heading) {
        if (heading.classList.contains(classToToggle)) {
          heading.classList.remove(classToToggle);
        } else {
          heading.classList = [classToToggle];
        }
      });
    },

    // Link Styles
    toggleLinkStyles: function (classToToggle, element) {
      var selectedLinks = this.selection.getInlines({
        all: true,
        tags: [element],
      });

      selectedLinks.forEach(function (element) {
        // Cross-browser toggle class
        if (element.classList) {
          if (element.classList.contains(classToToggle)) {
            element.classList.remove(classToToggle);
          } else {
            element.classList = [classToToggle];
          }
        }
      });
    }
  });
})(Redactor);
