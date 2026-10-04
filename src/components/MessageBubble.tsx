import type { ChatMessage } from '../types/message'

type MessageBubbleProps = {
  message: ChatMessage
}

export default function MessageBubble({ message }: MessageBubbleProps) {
  const isUser = message.author === 'user'

  return (
    <div className={`flex ${isUser ? 'justify-end' : 'justify-start'}`}>
      <div
        aria-label={isUser ? 'Mensagem do usuário' : 'Mensagem do robô'}
        className={[
          'max-w-[85%] rounded-2xl border px-3 py-2 shadow-sm',
          isUser
            ? 'border-emerald-200 bg-emerald-100 text-stone-800'
            : 'border-stone-200 bg-white text-stone-800',
        ].join(' ')}
      >
        <div className="mb-1 text-[11px] font-semibold uppercase tracking-[0.12em] text-stone-500">
          {isUser ? 'Usuário' : 'Robô'}
        </div>
        <p className="whitespace-pre-wrap break-words text-sm leading-6">{message.content}</p>
      </div>
    </div>
  )
}
