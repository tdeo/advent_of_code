class PasswordPhilosophy
  def initialize(input)
    @input = input

    @policies = []
    @passwords = []

    @input.each_line do |line|
      policy, password = line.split(': ')
      @passwords << password.chars
      policy = policy.split(' ')
      @policies << [
        policy[1],
        policy[0].split('-').map(&:to_i),
      ]
    end
  end

  def valid?(password, policy)
    occurences = password.count(policy[0])
    occurences >= policy[1][0] && occurences <= policy[1][1]
  end

  def part1
    @passwords.each_with_index.count { |pass, i| valid?(pass, @policies[i]) }
  end

  def valid2?(password, policy)
    (password[policy[1][0] - 1]  == policy[0]) ^ (password[policy[1][1] - 1] == policy[0])
  end

  def part2
    @passwords.each_with_index.count { |pass, i| valid2?(pass, @policies[i]) }
  end
end
