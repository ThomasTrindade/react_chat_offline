import { useEffect, useRef, type Dispatch, type KeyboardEvent, type SetStateAction } from 'react'
import type { Author } from '../types/message'

type ChatComposerProps = {
  author: Author
  draft: string
  setDraft: Dispatch<SetStateAction<string>>
  onAuthorChange: (value: Author) => void
  onSubmit: () => void
}

export default function ChatComposer({
  author,
  draft,
  setDraft,
  onAuthorChange,
  onSubmit,
}: ChatComposerProps) {
  const textareaRef = useRef<HTMLTextAreaElement>(null)
  const authorButtonRefs = useRef<HTMLButtonElement[]>([])
  const isRobot = author === 'robot'
  const isDisabled = draft.trim().length === 0

  useEffect(() => {
    const textarea = textareaRef.current
    if (!textarea) return

    textarea.style.height = 'auto'
    textarea.style.height = `${Math.min(textarea.scrollHeight, 144)}px`
  }, [draft])

  const handleKeyDown = (event: KeyboardEvent<HTMLTextAreaElement>) => {
    if (event.key === 'Enter' && !event.shiftKey) {
      event.preventDefault()
      if (!isDisabled) {
        onSubmit()
      }
    }
  }

  const handleAuthorKeyDown = (
    event: KeyboardEvent<HTMLButtonElement>,
    currentAuthor: Author,
  ) => {
    const currentIndex = currentAuthor === 'user' ? 0 : 1
    let nextIndex = currentIndex

    if (event.key === 'ArrowRight' || event.key === 'ArrowDown') {
      nextIndex = (currentIndex + 1) % 2
    } else if (event.key === 'ArrowLeft' || event.key === 'ArrowUp') {
      nextIndex = (currentIndex + 1) % 2
    } else if (event.key === 'Home') {
      nextIndex = 0
    } else if (event.key === 'End') {
      nextIndex = 1
    } else {
      return
    }

    event.preventDefault()
    const nextAuthor = nextIndex === 0 ? 'user' : 'robot'
    onAuthorChange(nextAuthor)
    authorButtonRefs.current[nextIndex]?.focus()
  }

  return (
      <div className="shrink-0 border-t border-stone-200 bg-[#f9f7f5] px-3 pb-3 pt-3 sm:px-4">
      <form
        className={[
          'rounded-2xl border bg-white p-3 shadow-sm transition-colors duration-200 sm:p-4',
          isRobot ? 'border-violet-500 ring-2 ring-violet-200' : 'border-stone-200',
        ].join(' ')}
        onSubmit={(event) => {
          event.preventDefault()
          if (!isDisabled) {
            onSubmit()
          }
        }}
      >
        <div className="flex flex-col gap-3 sm:flex-row sm:items-end">
          <div className="flex items-center gap-2" role="radiogroup" aria-label="Selecionar autoria da mensagem">
            {(['user', 'robot'] as Author[]).map((option) => {
              const selected = author === option
              return (
                <button
                  key={option}
                  type="button"
                  role="radio"
                  aria-checked={selected}
                  tabIndex={selected ? 0 : -1}
                  aria-label={option === 'user' ? 'Mensagem do usuário' : 'Mensagem do robô'}
                  ref={(element) => {
                    if (element) authorButtonRefs.current[option === 'user' ? 0 : 1] = element
                  }}
                  onClick={() => onAuthorChange(option)}
                  onKeyDown={(event) => handleAuthorKeyDown(event, option)}
                  className={[
                    'rounded-full border px-3 py-1.5 text-sm font-medium transition-colors focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-violet-500',
                    selected
                      ? option === 'user'
                        ? 'border-emerald-400 bg-emerald-100 text-emerald-900'
                        : 'border-violet-400 bg-violet-100 text-violet-900'
                      : 'border-stone-300 bg-white text-stone-600 hover:bg-stone-50',
                  ].join(' ')}
                >
                  {option === 'user' ? 'Usuário' : 'Robô'}
                </button>
              )
            })}
          </div>

          <div className="flex min-w-0 flex-1 flex-col gap-2">
            <textarea
              ref={textareaRef}
              value={draft}
              onChange={(event) => setDraft(event.target.value)}
              onKeyDown={handleKeyDown}
              rows={1}
              aria-label="Mensagem"
              placeholder="Digite sua mensagem..."
              className="max-h-36 min-h-[44px] w-full resize-none overflow-y-auto rounded-xl border border-stone-200 bg-stone-50 px-3 py-2 text-sm leading-6 text-stone-800 placeholder:text-stone-400 focus:border-stone-400 focus:outline-none focus:ring-2 focus:ring-violet-200"
            />
            <div className="flex items-center justify-end">
              <button
                type="submit"
                disabled={isDisabled}
                className="rounded-xl bg-stone-900 px-4 py-2 text-sm font-medium text-white transition-colors disabled:cursor-not-allowed disabled:bg-stone-300 disabled:text-stone-500 hover:bg-stone-700 focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-violet-500"
              >
                Enviar
              </button>
            </div>
          </div>
        </div>
      </form>
    </div>
  )
}
