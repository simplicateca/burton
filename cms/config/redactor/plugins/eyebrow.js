//Based on https://www.jackbarber.co.uk/blog/2019-04-26-email-address-plugin-for-redactor with small improvements
(function ($R) {
    $R.add('plugin', 'eyebrow', {

        init: function (app) {
            this.app       = app;
            this.lang      = app.lang;
            this.toolbar   = app.toolbar;
            this.insertion = app.insertion;
            this.selection = app.selection;
            this.inspector = app.inspector;
            this.opts      = app.opts;
        },

        // set translations
        translations: {
            en: {
                "buttonLabel": "Eyebrow",
                "eyebrowField": "Eyebrow Text",
                "styleField": "Style",
                "eyebrowInfo": "Eyebrow Text is a descriptive keyword or short phrase placed above a headline or section. One eyebrow element may exist per text block.",
                "modalTitle": "Editing Eyebrow Text",
                "cancel": "Cancel",
                "remove": "Remove",
                "update": "Update",
                "save": "Save",
            },
        },

        start: function () { 
            // add the button to the toolbar
            this.toolbar.addButton('eyebrow', {
                title: this.lang.get('buttonLabel'),
                api: 'plugin.eyebrow.open',
                icon: '<svg version="1.0" xmlns="http://www.w3.org/2000/svg" width="16" height="16" viewBox="0 0 512 512"><path d="M268 61.7c-12.2 1.1-23.7 2.7-31.5 4.3C212.7 70.9 9.3 122.2 7 123.9c-3.8 2.8-7 8-7 11.6 0 4 23 70.2 26.4 75.9 3 5.2 12 13.8 17.2 16.4 9.6 4.9 22.8 6.6 31.9 4.1 2.2-.6 42.7-15.3 90-32.6 89.8-32.9 101.2-36.5 126.6-40.4 19-2.9 54.2-3.2 72.4-.6 46.4 6.8 82.2 21.1 121.9 48.6 4.5 3.1 6.8 4.1 9.8 4.1 8.3 0 14.6-5.5 15.5-13.4.4-3.6-.2-5.6-4.7-14.1-40.4-78-121.2-123.3-218.4-122.3-9.4 0-18.7.3-20.6.5zm60.5 31.8c41.3 6.4 77.7 22.3 106 46.3 4.8 4.1 8.5 7.6 8.3 7.8-.3.2-5.9-1.6-12.5-4.1-48-17.7-105.2-22.1-156.8-12-18.3 3.6-35.1 9.3-118.1 39.6C99.9 191.4 66.9 203 64.6 203c-4.6 0-8.9-2.1-11.4-5.7-2.6-3.7-18.5-49.4-17.5-50.3.8-.8 197.6-49.8 208.8-52 21.1-4.3 61.6-5 84-1.5zM458.4 273.5c-2.7 1.3-13.9 9.5-24.9 18-44.8 34.9-71.7 49.8-108.6 60.4-37.1 10.6-83 12-119.9 3.5-25-5.7-40.9-12.1-85.8-34.7-34.1-17.1-38.9-19.2-43.2-19.2-8.5 0-15.5 7.4-14.7 15.6.6 7.5 3.4 10.2 17 17.1 6.7 3.3 12.4 6.2 12.6 6.4.2.2-4.8 8.2-11.1 17.7-14.7 22-15.1 22.9-14.5 28.5 1.1 10.3 11.3 15.9 21.2 11.8 2.8-1.2 5.9-5.3 17.4-22.5 7.8-11.6 14.5-21.1 15.1-21.1.5 0 6.2 2.6 12.7 5.8 6.5 3.2 16.8 7.8 22.9 10.2l11.1 4.4-6 23.8c-6.4 25.8-6.6 28.4-2.2 33.7 7.1 8.3 20 6.8 24.9-2.9.7-1.4 3.7-12.2 6.6-24 2.9-11.8 5.4-21.6 5.5-21.8.1-.1 6.5.9 14.1 2.3s18 2.9 22.9 3.3l9 .7.5 25.5c.5 24.9.6 25.6 2.9 28.9 6.2 8.6 19.5 7.9 24.8-1.5 2.2-3.7 2.3-4.9 2.3-28.1v-24.2l5.8-.6c17.6-1.8 25.4-2.8 31.5-4.1 3.8-.8 7.4-1.4 8.1-1.4.9 0 3.3 7.6 7.1 23.1 4.9 19.7 6.2 23.7 8.7 26.5 7.1 8.1 19.4 5.9 24.7-4.3 1.8-3.5 1.4-6.2-4.4-29.3-3-12.1-5.5-22.5-5.5-23.2 0-.7 4.2-2.8 9.3-4.7 5-1.8 15.7-6.4 23.6-10.2 7.9-3.8 14.5-6.8 14.6-6.7.1.2 6.2 9.2 13.4 20.1 14.2 21.4 16.6 23.7 23.9 23.7 10 0 16.8-8.4 14.7-18-.4-1.8-6.5-12-13.7-22.7-10.6-16-12.7-19.8-11.6-20.8.7-.7 13.8-10.5 29-21.9 25.4-19 27.8-21 29.3-25.1 3-7.7-.5-15.9-8.2-19.1-4.6-2-7.2-1.7-12.9 1.1z"/></svg>'
            });            
        },

        // messages
        onmodal: {
            eyebrowModal: {
                open: function (modal, form) {
                    this.$modal = modal
                    this.$form = form
                    this._setup()
                },

                insert: function () {
                    this._scrubEyebrows()
                    this._insertNewEyebrow()
                    this.app.api('module.modal.close');
                },

                remove: function() {
                    this._scrubEyebrows()
                    this.app.api('module.modal.close');
                }
            }
        },

        _setup() {

            this.$form.find('#eyebrowInfo').text( this.lang.get('eyebrowInfo') )
            this.$form.find('#eyebrowLabel').text( this.lang.get('eyebrowField') )
            this.$form.find('#eyebrowStyleLabel').text( this.lang.get('styleField') )

            var style = this.$form.find('select[name=style]')
            this.opts.eyebrows.forEach(function(element) {
                style.append(`<option value='${element.class}'>${element.label}</option>`)
            });

            if( this.firstEyebrow ) {
                this.$form.find('input[name=text]').val( this.firstEyebrow.innerText.replace('--blank--','') )

                var classList = this.firstEyebrow
                    .getAttribute('class')
                    .replace( 'eyebrow ', '' ).trim()
                
                this.$form.find('select[name=style]').val( classList )
            }
        },

        _insertNewEyebrow() {
            var data = this.$form.getData();
            var text = ( data.text.trim() === '') ? '<strong>--blank--</strong>' : data.text
            var html = `<div class="eyebrow ${data.style}">${text}</div>`;
            this._appendEyebrow(html)
        },

        open: function () {

            this._scrubEyebrows()

            if( this.firstEyebrow ) {
                this._appendEyebrow( this.firstEyebrow.outerHTML )
            }

            var commands = this.firstEyebrow ?
                {    
                    cancel: { title: this.lang.get('cancel') },
                    insert: { title: this.lang.get('update') },
                    remove: { title: this.lang.get('remove') }
                } :  {
                    cancel: { title: this.lang.get('cancel') },
                    insert: { title: this.lang.get('save') },
                }

            var options = {
                title: this.lang.get('modalTitle'),
                name: 'eyebrowModal',
                commands: commands
            };
  
            this.app.api('module.modal.build', options)
        },

        _scrubEyebrows: function() {

            this.selection.setAll()
            var blocks = this.selection.getBlocks()
            this.selection.clear()

            var foundFirst = null
            $R.dom(blocks).each(function(node){
                if( node.tagName == 'DIV' && node.classList.contains('eyebrow') ) {
                    if( !foundFirst ) { foundFirst = node }
                    node.remove()
                }
            })

            this.firstEyebrow = foundFirst
        },

        _appendEyebrow: function( eyebrowHtml ) {
            if( eyebrowHtml ) {
                this.selection.setAll()
                var html = this.selection.getHtml()
                this.insertion.insertHtml( eyebrowHtml + html )
            }           
        },

        modals: {
            'eyebrowModal': `
                <form action="">
                    <p id='eyebrowInfo'></p>
                    <div class="form-item" style="display:flex;">
                        <div style="flex-grow:1; margin-right: 20px;">
                            <label><b id='eyebrowLabel'></b></label>
                            <input type="text" name="text" style="margin-bottom: 10px;">
                        </div>
                    
                        <div>
                            <label><b id='eyebrowStyleLabel'></b></label>
                            <select name="style"></select>
                        </div>
                    </div>
                </form>`
        }
    });
})(Redactor);