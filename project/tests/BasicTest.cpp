#include <gtest/gtest.h>

class BasicTest : public ::testing::Test {
};

TEST_F(BasicTest, basic_test) {
  EXPECT_TRUE(2 + 2 == 4);
}
