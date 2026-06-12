import { defineConfig } from 'vitepress'

export default defineConfig({
  title: 'monads',
  description: 'Monads for Crystal — Maybe, Either, List, Try and Task',

  // GitHub Pages base path
  base: '/monads/',

  // Clean URLs without .html
  cleanUrls: true,

  // Last updated timestamp
  lastUpdated: true,

  head: [
    ['meta', { name: 'theme-color', content: '#f06529' }],
    ['meta', { property: 'og:type', content: 'website' }],
    ['meta', { property: 'og:title', content: 'monads - Monads for Crystal' }],
    ['meta', { property: 'og:description', content: 'Composable Maybe, Either, List, Try and Task monads for Crystal' }],
  ],

  themeConfig: {
    nav: [
      { text: 'Guide', link: '/guide/', activeMatch: '/guide/' },
      { text: 'API', link: '/api/', activeMatch: '/api/' },
      { text: 'Examples', link: '/examples/', activeMatch: '/examples/' },
      {
        text: 'Links',
        items: [
          { text: 'Changelog', link: '/changelog' },
          { text: 'Contributing', link: '/contributing' },
          { text: 'Releases', link: 'https://github.com/alex-lairan/monads/releases' },
        ]
      }
    ],

    sidebar: {
      '/guide/': [
        {
          text: 'Introduction',
          items: [
            { text: 'What is monads?', link: '/guide/' },
            { text: 'Getting Started', link: '/guide/getting-started' },
            { text: 'Chaining Monads', link: '/guide/chaining' },
          ]
        },
        {
          text: 'The Monads',
          items: [
            { text: 'Maybe', link: '/guide/maybe' },
            { text: 'Either', link: '/guide/either' },
            { text: 'List', link: '/guide/list' },
            { text: 'Try', link: '/guide/try' },
            { text: 'Task', link: '/guide/task' },
          ]
        }
      ],
      '/api/': [
        {
          text: 'API Reference',
          items: [
            { text: 'Overview', link: '/api/' },
            { text: 'Functor', link: '/api/functor' },
            { text: 'Monad', link: '/api/monad' },
            { text: 'Maybe', link: '/api/maybe' },
            { text: 'Either', link: '/api/either' },
            { text: 'List', link: '/api/list' },
            { text: 'Try', link: '/api/try' },
            { text: 'Task', link: '/api/task' },
            { text: 'Errors', link: '/api/errors' },
          ]
        }
      ],
      '/examples/': [
        {
          text: 'Examples',
          items: [
            { text: 'Overview', link: '/examples/' },
            { text: 'Error Handling with Either', link: '/examples/error-handling' },
            { text: 'Avoiding nil with Maybe', link: '/examples/avoiding-nil' },
          ]
        }
      ]
    },

    socialLinks: [
      { icon: 'github', link: 'https://github.com/alex-lairan/monads' }
    ],

    footer: {
      message: 'Released under the MIT License.',
      copyright: 'Copyright 2021-present Alexandre Lairan'
    },

    search: {
      provider: 'local'
    },

    editLink: {
      pattern: 'https://github.com/alex-lairan/monads/edit/master/docs/:path',
      text: 'Edit this page on GitHub'
    },

    outline: {
      level: [2, 3]
    }
  },

  markdown: {
    theme: {
      light: 'github-light',
      dark: 'github-dark'
    },
    lineNumbers: true
  }
})
