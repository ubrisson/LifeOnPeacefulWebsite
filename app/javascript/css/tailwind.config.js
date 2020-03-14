module.exports = {
    variants: {},
    plugins: [],
    theme: {
        extend: {
            width: {
                '1/10': '10%',
                '1/8': '12,5%',
            },
            screens: {
                '2xl': '1440px',
                '3xl': '1700px',
                'nymous':'2500px',
            },
            minWidth: {
                '1/10': '10%',
                '1/8': '12.5%',
            },
            textColor: {
                primary: "var(--color-text-primary)",
                secondary  : "var(--color-text-secondary)",
                default: "var(--color-text-default)",
                "default-soft": "var(--color-text-default-soft)",
                inverse: "var(--color-text-inverse)",
                "inverse-soft": "var(--color-text-inverse-soft)"
            },
            backgroundColor: {
                primary: "var(--color-bg-primary)",
                secondary: "var(--color-bg-secondary)",
                default: "var(--color-bg-default)",
                inverse: "var(--color-bg-inverse)",
                tertiary: "var(--color-bg-tertiary)"
            },
            borderColor: {
                primary: "var(--color-border-primary)",
                secondary: "var(--color-border-secondary)",
            }
        }
    }
};
