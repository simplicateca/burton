 <template>
    <div class="container">
        <h1>Random Unicorn Generator</h1>

        <h2 class="subtitle" v-if="!name">Click the button below to generate a random unicorn!</h2>

        <div id="unicorn" @transitionend="load()">

        <p class="subtitle" v-if="name">Meet <strong>{{name}}</strong>!</p>

        <div class="unicorn" v-if="showUnicorn">
            <Unicorn
                :color1="color1"
                :color2="color2"
                :color3="color3"
                :color4="color4"
                :color5="color5"
                :color6="color6"
            />
        </div>

        <h3 v-if="name">{{name}} is a very {{attribute1}} and {{attribute2}} unicorn.</h3>

        <button @click="generate()" id="generate" class="button is-large">{{button}}</button>
    </div>
</template>

<script>
  import axios   from 'axios'
  import Unicorn from '~/components/Unicorn.vue'

  export default {
    data () {
        return {
          button     : "Let's Get Started!",
          showUnicorn: false,
          name       : '',
          attribute1 : '',
          attribute2 : '',
          color1     : '',
          color2     : '',
          color3     : '',
          color4     : '',
          color5     : '',
          color6     : '',
        }
    },

    methods: {
      generate: function (event) {
        if( this.showUnicorn ) {
          document.querySelector('#generate').disabled = true;
          document.querySelector('#unicorn').classList.add( 'hiding' );
        } else {
          document.querySelector('#generate').blur();
          this.getunicorn();
        }
      },

      load: function (event) {
        if( document.querySelector('#unicorn').classList.contains( 'hiding' ) ) {
          this.getunicorn();
        }
      },

      getunicorn: function(event) {
        axios
          .get('https://www.random-unicorn.com/api/v1/generate')
          .then(response => {
            this.name        = response.data.name;
            this.attribute1  = response.data.attribute1;
            this.attribute2  = response.data.attribute2;
            this.color1      = response.data.color1;
            this.color2      = response.data.color2;
            this.color3      = response.data.color3;
            this.color4      = response.data.color4;
            this.color5      = response.data.color5;
            this.color6      = response.data.color6;
            this.showUnicorn = true;
            this.button      = "Do Magic Again";

            document.querySelector('#unicorn').classList.remove( 'hiding' );
            document.querySelector('#generate').disabled = false;
          });
      },
    },

    components: {
      Unicorn
    }
  }
</script>

<style lang="scss" scoped>
  #unicorn {
    margin    : 0 12px;
    transition: all 0.3s ease;
    opacity   : 1;

    &.hiding {
      opacity: 0;
    }
  }

  svg {
    max-height: 60vh;
    margin-top: 20px;
  }
</style>
