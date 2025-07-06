module ApplicationHelper
  def notification(data)
    return if data.blank?

    <<-HTML.chomp
      <div id="notice" aria-live="assertive" class="z-100 pointer-events-none fixed inset-0 flex items-end px-4 py-12 sm:items-start">
        <div class="flex w-full flex-col items-center space-y-4 sm:items-end">
          <div class="pointer-events-auto w-full max-w-sm overflow-hidden rounded-lg bg-gradient-to-r from-emerald-100 to-white shadow-lg p-4">
            <div class="flex items-start">
              <div class="flex-shrink-0">
                <svg class="h-6 w-6 text-green-400" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor" aria-hidden="true">
                  <path stroke-linecap="round" stroke-linejoin="round" d="M9 12.75L11.25 15 15 9.75M21 12a9 9 0 11-18 0 9 9 0 0118 0z" />
                </svg>
              </div>
              <div class="ml-3 w-0 flex-1 pt-0.5">
                <p class="text-sm font-medium text-gray-900">#{data}</p>
              </div>
              <div class="ml-4 flex flex-shrink-0">
                <button type="button" class="inline-flex rounded-md bg-white text-gray-400 hover:text-gray-500 cursor-pointer" onclick="$('#notice').remove();">
                  <svg class="h-5 w-5" viewBox="5 0 15 15" fill="currentColor" aria-hidden="true">
                    <path d="M6.28 5.22a.75.75 0 00-1.06 1.06L8.94 10l-3.72 3.72a.75.75 0 101.06 1.06L10 11.06l3.72 3.72a.75.75 0 101.06-1.06L11.06 10l3.72-3.72a.75.75 0 00-1.06-1.06L10 8.94 6.28 5.22z" />
                  </svg>
                </button>
              </div>
            </div>
          </div>
        </div>
      </div>
    HTML
  end
end
