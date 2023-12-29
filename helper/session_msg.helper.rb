def create_session_msg(text, expire_after)
  { text: text, expire_after: Time.now + expire_after }
end
