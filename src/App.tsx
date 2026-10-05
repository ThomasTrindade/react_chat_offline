import { useEffect, useRef, useState } from 'react'
import ChatComposer from './components/ChatComposer'
import ChatHistory from './components/ChatHistory'
import type { Author, ChatMessage } from './types/message'

export default function App() {
  const [messages, setMessages] = useState<ChatMessage[]>([])
  const [draft, setDraft] = useState('')
  const [author, setAuthor] = useState<Author>('user')
  const listRef = useRef<HTMLDivElement>(null)

  useEffect(() => {
    const container = listRef.current
    if (!container) return

    container.scrollTop = container.scrollHeight
  }, [messages])

  const handleSubmit = () => {
    const trimmed = draft.trim()
    if (!trimmed) return

    const nextMessage: ChatMessage = {
      id: crypto.randomUUID(),
      author,
      content: draft,
    }

    setMessages((current) => [...current, nextMessage])
    setDraft('')
  }

  return (
      <div className="min-h-[var(--viewport-height)] bg-[#f1e4d2] px-3 py-3 text-stone-800 sm:px-4">
      <div className="mx-auto flex h-[calc(var(--viewport-height)-1.5rem)] w-full max-w-2xl flex-col overflow-hidden rounded-2xl border border-stone-200 bg-[#f9f5f1] shadow-sm">
        <ChatHistory messages={messages} listRef={listRef} />
        <ChatComposer
          author={author}
          draft={draft}
          setDraft={setDraft}
          onAuthorChange={setAuthor}
          onSubmit={handleSubmit}
        />
      </div>
    </div>
  )
}