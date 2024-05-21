<template>
    <div
        class="w-full @container"
    >
        <div
            v-if="showUnicorn"
            class="text-center @container pb-12"
        >
            <div class="eyebrow text-sm uppercase font-headline text-theme-accent">
                Introducing
            </div>
            <h3 v-if="name">
                <strong>{{ name }}</strong>
            </h3>

            <p
                v-if="name"
                class="larger text-center max-w-md mx-auto"
            >
                {{ name }} is a {{ intensifier1 }} {{ attribute1 }} and {{ intensifier2 }} {{ attribute2 }} unicorn.
            </p>
        </div>

        <div
            class="text-center"
        >
            <button
                id="generate"
                class="button"
                @click="generate()"
            >
                {{ button }}
            </button>
        </div>

        <div
            v-if="showUnicorn"
            id="unicorn"
            class="grid grid-cols-2 gap-20"
            @transitionend="load()"
        >
            <div class="@container flex flex-col items-center justify-center p-5">
                <h4>Colour Palette</h4>

                <div class="grid grid-cols-3 gap-6 px-6 w-3/4">
                    <div
                        v-for="(color, index) in colors"
                        :key="index"
                        class="flex flex-col gap-2"
                    >
                        <div class="aspect-square" :style="{ backgroundColor: color.hex.value }">&nbsp;</div>
                        <strong class="text-xs text-center">{{  color.name.value }}</strong>
                    </div>
                </div>
            </div>

            <div class="unicorn">
                <UnicornArt
                    :color1="color1"
                    :color2="color2"
                    :color3="color3"
                    :color4="color4"
                    :color5="color5"
                    :color6="color6"
                />
            </div>
        </div>
    </div>
</template>

<script>
    import UnicornArt from '/vue/UnicornArt.vue'

    const unicornTraits = [
        "sparkly", "glittery", "rainbow", "shiny", "magical", "playful", "mystic", "quirky",
        "cheerful", "whimsical", "dreamy", "friendly", "joyful", "loyal", "curious", "witty",
        "happy", "brave", "graceful", "radiant", "jolly", "gentle", "cuddly", "silly", "bubbly",
        "dazzling", "charming", "merry", "energetic", "gleaming", "prancing", "mischievous",
        "giggly", "fanciful", "fuzzy", "swift", "nimble", "fluffy", "sweet", "chirpy", "flamboyant",
        "vibrant", "blissful", "adorable", "radiant", "glistening", "wondrous", "gleeful", "frolicsome",
        "colorful", "elegant", "fantastic", "majestic", "enchanting", "peppy", "jubilant", "spritely",
        "luminous", "twinkly", "vivacious", "bouncy", "serene", "snazzy", "pizzazz", "sunny", "bright",
        "soaring", "nimble", "snuggly", "zippy", "dynamic", "cheery", "joyous", "effervescent",
        "gleeful", "radiant", "spritely", "whimsical", "fantastical", "laughing", "blithesome",
        "frolicsome", "zany", "sprightly", "effulgent", "exuberant", "twinkling", "animated", "bubbly",
        "zestful", "chipper", "peppy", "upbeat", "sparkling", "beaming", "exultant", "jovial", "buoyant",
        "mirthful", "plucky"
    ];

    const unicornNames = [
        "Twilight", "Sparkle", "Rainbow", "Starfire", "Celestia", "Luna", "Sunbeam", "Starlight",
        "Moonbeam", "Glitter", "Spark", "Nova", "Dazzle", "Harmony", "Sky", "Blossom", "Aurora",
        "Mystic", "Dream", "Whimsy", "Fantasia", "Glimmer", "Serenity", "Breeze", "Bubbles",
        "Flutter", "Twinkle", "Joy", "Wishes", "Marigold", "Snowflake", "Fairy", "Rose", "Lavender",
        "Petal", "Pixie", "Starry", "Silver", "Goldie", "Clover", "Sugar", "Frost", "Diamond",
        "Ruby", "Emerald", "Sapphire", "Pearl", "Opal", "Coral", "Crystal", "Misty", "Sunny",
        "Flicker", "Comet", "Nebula", "Dreamer", "Poppy", "Bliss", "Echo", "Skye", "Harmony",
        "Magic", "Wish", "Shimmer", "Breezy", "Cupcake", "Pearly", "Tinsel", "Fae", "Dewdrop",
        "Moonlight", "Petunia", "Sprinkles", "Daisy", "Lily", "Fern", "Buttercup", "Pansy",
        "Tulip", "Lilac", "Bluebell", "Snowdrop", "Rosebud", "Jasmine", "Willow", "Peony",
        "Azalea", "Dandelion", "Ivy", "Violet", "Fuchsia", "Starshine", "Luminous", "Aurora",
        "Gleam", "Wondrous", "Radiant", "Prism", "Glory", "Dreamy"
    ];

    export default {
        components: {
            UnicornArt
        },

        data () {
            return {
                button     : "Let's Get Started!",
                showUnicorn: false,
                name       : '',
                intensifier: '',
                attribute1 : '',
                attribute2 : '',
                colors     : [],
                color1     : '',
                color2     : '',
                color3     : '',
                color4     : '',
                color5     : '',
                color6     : '',
            }
        },

        methods: {
            randomhex: function () {
                const randomColor = Math.floor(Math.random() * 16777216)
                return `${randomColor.toString(16).padStart(6, '0')}`
            },

            getscheme: async function () {
                const url = "https://www.thecolorapi.com/scheme?hex=" + this.randomhex() + "&format=json&mode=analogic&count=6";
                try {
                    const response = await fetch(url, {
                        headers: {
                            'Accept': 'application/json'
                        }
                    });

                    if (!response.ok) {
                        throw new Error(`HTTP error! Status: ${response.status}`);
                    }

                    const data = await response.json();

                    this.color1 = data.colors[0].hex.value;
                    this.color2 = data.colors[1].hex.value;
                    this.color3 = data.colors[2].hex.value;
                    this.color4 = data.colors[3].hex.value;
                    this.color5 = data.colors[4].hex.value;
                    this.color6 = data.colors[5].hex.value;

                    this.colors = data.colors

                    this.showUnicorn = true
                    this.button      = "Do Magic Again"

                    this.name         = this.rename()
                    const traits      = this.traits()
                    this.attribute1   = traits[0]
                    this.attribute2   = traits[1]
                    this.intensifier1 = this.getintense()
                    this.intensifier2 = this.getintense()

                    document.querySelector('#unicorn').classList.remove( 'hiding' );
                    document.querySelector('#generate').disabled = false;

                } catch (error) {
                    console.error('Error fetching the color scheme:', error);
                }
            },

            getintense: function() {
                const intensifiers = [
                    "very", "extremely", "highly", "incredibly", "exceptionally",
                    "remarkably", "profoundly", "tremendously", "super", "immensely",
                    "vastly", "hugely", "terribly", "awfully", "supremely",
                    "totally", "utterly", "deeply", "greatly", "particularly",
                    "decidedly", "notably", "thoroughly", "overwhelmingly", "staggeringly",
                    "intensely", "exceedingly", "supremely", "radically", "phenomenally",
                    "drastically", "monumentally", "colossally", "stupendously", "absurdly",
                    "ridiculously", "extraordinarily", "abundantly", "strikingly", "entirely",
                    "eminently", "uncommonly", "supersized", "wildly", "amazingly",
                    "fabulously", "magnificently", "splendidly", "wonderfully", "fantastically"
                ];
                const randomIndex = Math.floor(Math.random() * intensifiers.length);
                return intensifiers[randomIndex];
            },

            rename: function () {
                const index1 = Math.floor(Math.random() * unicornNames.length);
                let index2;
                do {
                    index2 = Math.floor(Math.random() * unicornNames.length);
                } while (index1 === index2);
                return unicornNames[index1] + ' ' + unicornNames[index2];
            },

            traits: function () {
                const index1 = Math.floor(Math.random() * unicornTraits.length);
                let index2;
                do {
                    index2 = Math.floor(Math.random() * unicornTraits.length);
                } while (index1 === index2);
                return [unicornTraits[index1], unicornTraits[index2]];
            },

            generate: function () {
                if( this.showUnicorn ) {
                    document.querySelector('#generate').disabled = true;
                    document.querySelector('#unicorn').classList.add( 'hiding' );
                } else {
                    document.querySelector('#generate').blur();
                    this.getscheme();
                }
            },

            load: function () {
                if( document.querySelector('#unicorn').classList.contains( 'hiding' ) ) {
                    this.getscheme();
                }
            }
        }
    }
</script>

<style lang="css" scoped>
    #unicorn {
        margin    : 0 12px;
        transition: all 0.3s ease;
        opacity   : 1;
    }

    #unicorn.hiding {
        opacity: 0;
    }

    svg {
        max-height: 60vh;
        margin-top: 20px;
    }
</style>
