export type Author = 'user' | 'robot'

export type ChatMessage = {
  id: string
  author: Author
  content: string
}
