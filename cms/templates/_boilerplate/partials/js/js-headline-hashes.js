<script>
    document.addEventListener('DOMContentLoaded', () => {
        let hash = window.location.hash;
        if (hash) {
            window.location.hash = '#';
            window.location.hash = hash;
        }
    }, false);

    const $headers = $(".article-content > h3");

    $headers.each((i, el) => {
    const $el = $(el);

    // Probably a flexbox layout style page
    if ($el.has("a").length != 0) {
        return;
    }

    let idToLink = "";

    if ($el.attr("id") === undefined) {
        // give it ID
        idToLink = "article-header-id-" + i;
        $el.attr("id", idToLink);
    } else {
        // already has ID
        idToLink = $el.attr("id");
    }

    const $headerLink = $("<a />", {
        html: "#",
        class: "article-headline-link",
        href: "#" + idToLink
    });

    $el.addClass("has-header-link").prepend($headerLink);
    });
</script>